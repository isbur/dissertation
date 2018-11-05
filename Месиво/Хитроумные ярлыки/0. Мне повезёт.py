#$shortcuts = Get-ChildItem *.lnk
#$randomValue = Get-Random -Maximum 3
#explorer $shortcuts[$randomValue]

# Just to get shortcut target...
import os, sys
import glob
import pythoncom
from win32com.shell import shell, shellcon


# as is from here: http://timgolden.me.uk/python/win32_how_do_i/read-a-shortcut.html
def shortcut_target (filename):
  link = pythoncom.CoCreateInstance (
    shell.CLSID_ShellLink,    
    None,
    pythoncom.CLSCTX_INPROC_SERVER,    
    shell.IID_IShellLink
  )
  link.QueryInterface (pythoncom.IID_IPersistFile).Load (filename)
  #
  # GetPath returns the name and a WIN32_FIND_DATA structure
  # which we're ignoring. The parameter indicates whether
  # shortname, UNC or the "raw path" are to be
  # returned. Bizarrely, the docs indicate that the 
  # flags can be combined.
  #
  name, _ = link.GetPath (shell.SLGP_UNCPRIORITY)
  return name

def shell_glob (pattern):
  for filename in glob.glob (pattern):
    if filename.endswith (".lnk"):
      yield "%s => %s" % (filename, shortcut_target (filename))
    else:
      yield filename

desktop = shell.SHGetSpecialFolderPath (None, shellcon.CSIDL_DESKTOP)
for filename in shell_glob (os.path.join (desktop, "*")):
  print (filename)

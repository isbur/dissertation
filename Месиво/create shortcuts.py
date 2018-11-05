# https://www.blog.pythonlibrary.org/2010/01/23/using-python-to-create-shortcuts/

from glob import glob
import os
from pathlib import Path
from win32com.client import Dispatch
import winshell


shell = Dispatch('WScript.Shell')
nationalitiesList = ["Узбеки", "Армяне", "Казахи"]
for i, nationality in enumerate(nationalitiesList):
    fileslist = [Path(x) for x in glob("./*" + nationality + "*.xlsm")]
    for filename in fileslist:
        path =  Path.home() / 'Documents' / 'GitHub' / 'dissertation' / 'Месиво' / "Хитроумные ярлыки" / (str(i+1) + ". " + nationality) / (str(filename)+".lnk")
        target = Path.home() / 'Documents' / 'GitHub' / 'dissertation' / 'Месиво' / filename
        wDir = Path.home() / 'Documents' / 'GitHub' / 'dissertation' / 'Месиво' 
        icon = Path.home() / 'Documents' / 'GitHub' / 'dissertation' / 'Месиво' / filename
         
        shell = Dispatch('WScript.Shell')
        shortcut = shell.CreateShortCut(str(path))
        shortcut.Targetpath = str(target)
        shortcut.WorkingDirectory = str(wDir)
        shortcut.IconLocation = str(icon)
        shortcut.save()        
        print(
            path
            )
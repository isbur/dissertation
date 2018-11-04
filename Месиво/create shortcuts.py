from glob import glob
import os
from pathlib import Path
from win32com.client import Dispatch
import winshell


shell = Dispatch('WScript.Shell')
nationalitiesList = ["Узбеки", "Армяне", "Казахи"]
for i, nationality in enumerate(nationalitiesList):
    fileslist = [Path(x) for x in glob("./*" + nationality + "*.xlsx")]
    for filename in fileslist:
        path =  Path("./Хитроумные ярлыки/") / Path(str(i+1) + ". " + nationality) / Path(str(filename)+".lnk")
        target = filename
        wDir = Path('.')
        icon = filename
         
        shell = Dispatch('WScript.Shell')
        shortcut = shell.CreateShortCut(str(path))
        shortcut.Targetpath = str(target)
        shortcut.WorkingDirectory = str(wDir)
        shortcut.IconLocation = str(icon)
        shortcut.save()        
        print(
            Path("./Хитроумные ярлык/") / Path(str(i+1) + ". " + nationality) / filename
            )
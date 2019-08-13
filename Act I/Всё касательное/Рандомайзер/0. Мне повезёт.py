#$shortcuts = Get-ChildItem *.lnk
#$randomValue = Get-Random -Maximum 3
#explorer $shortcuts[$randomValue]
import glob
import random
from subprocess import call
filesnames = glob.glob("*.lnk")
call(["explorer", filesnames[random.randrange(len(filesnames))]])
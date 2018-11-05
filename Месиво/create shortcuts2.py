#$shortcuts = Get-ChildItem *.lnk
#$randomValue = Get-Random -Maximum 3
#explorer $shortcuts[$randomValue]
import glob
import random
print(glob.glob("Хитроумные ярлыки/*.lnk")[random.randrange(3)])
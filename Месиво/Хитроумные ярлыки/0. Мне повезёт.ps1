$shortcuts = Get-ChildItem *.lnk
$randomValue = Get-Random -Maximum 3
explorer $shortcuts[$randomValue]

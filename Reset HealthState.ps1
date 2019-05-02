net stop healthservice

Remove-Item "C:\Program Files\System Center Operations Manager 2007\Health Service State" -recurse

net start healthservice

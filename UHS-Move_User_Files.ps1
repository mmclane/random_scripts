Function Move-User-Files($netshare){
#This function will move all of the files and folders in HomeDir\documents\documents up one level and delete that folder.
    if(test-path $netshare\documents\documents){
        Write-host "$uniquename : Processing folder"
        move-item $netshare\documents\documents\* $netshare\documents\ -Force
        Remove-item $netshare\documents\documents -Force -Recurse
    }Else{Write-Host "$uniquename : Folder doesn't exist"}
}


$users = Get-Content 'C:\temp\UHS Move-Files Users.txt'
foreach ($uniquename in $users){
    $netshare = "\\uhs-users.m.storage.umich.edu\uhs-users\HomeFolders\$uniquename"
    Move-User-Files($netshare)
}




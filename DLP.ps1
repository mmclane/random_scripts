Param ([String]$networkPath)


$permsLogFile = "c:\temp\scanner-permissions.txt"
$permone = "UMROOT\m-dlp-scanner","Read","Allow"


$colRights = [System.Security.AccessControl.FileSystemRights]"ReadAndExecute" 
#$colRights = [System.Security.AccessControl.FileSystemRights]"FullControl"


#$InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]::None
$InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]"ContainerInherit, ObjectInherit"
$PropagationFlag = [System.Security.AccessControl.PropagationFlags]::None 


$objType =[System.Security.AccessControl.AccessControlType]::Allow 


$objUserOne = New-Object System.Security.Principal.NTAccount("UMROOT\m-dlp-scanner")


$dirs = dir $networkPath |?{ $_.PsIsContainer }


foreach ($Item in $dirs)
{
#Run Get-ACL for each folder
#$acl = Get-Acl $Item


    Get-acl $networkPath"\"$Item|Format-List|out-file $permsLogFile -Append


$objACEOne = New-Object System.Security.AccessControl.FileSystemAccessRule ($objUserOne, $colRights, $InheritanceFlag, $PropagationFlag, $objType) 


$objACL = Get-ACL $networkPath"\"$Item
 
$objACL.AddAccessRule($objACEOne)


Set-ACL $networkPath"\"$Item $objACL
 
    Get-acl $networkPath"\"$Item|Format-List|out-file $permsLogFile -Append
}

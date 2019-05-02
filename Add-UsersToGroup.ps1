Param([string]$user, [string]$GroupsFile)

Import-module ActiveDirectory  

$groups = Get-Content $GroupsFile

ForEach($g in $groups){
    Write-host "Adding $user to: $g"
    Add-ADGroupMember $g $user
}

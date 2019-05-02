$User = read-host -Prompt "User Name"

$user_dn = (get-mailbox $user).distinguishedname

"User " + $User + " is a member of the following groups:"

foreach ($group in get-distributiongroup -resultsize unlimited){

if ((get-distributiongroupmember $group.identity | select -expand distinguishedname) -contains $user_dn){$group.name}

}
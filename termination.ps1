param($user,$manager, $message="$user is no longer with Online Tech.  Please contact $manager with any questions")

$UserCredential = Get-Credential
Import-Module MSOnline
Connect-MsolService -Credential $UserCredential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking

$Message = "$user is no longer with Online Tech.  Please contact $manager with any questions"

Write-Host "Set Autoreply"
Set-MailboxAutoReplyConfiguration -Identity $user -AutoReplyState Enabled -ExternalMessage $message -InternalMessage $message

Write-Host "Forward mail to manager"
Set-Mailbox $user -ForwardingAddress $manager -DeliverToMailboxAndForward $False

Write-Host "In-place hold"

$InPlaceHoldMailboxes = (Get-MailboxSearch "Terminated Employees").sourceMailboxes  #Get current mailboxes in our mailbox search
$InPlaceHoldMailboxes += "$user"

Set-MailboxSearch "Terminated Employees" -SourceMailboxes $InPlaceHoldMailboxes -InPlaceHoldEnabled $true #Add them to the MailboxSearch with InPlaceHoldEnabled

Write-Host "Block User"
Set-MsolUser -UserPrincipalName $user -blockcredential $True  



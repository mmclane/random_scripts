param($user,$message)

$UserCredential = Get-Credential
Import-Module MSOnline
Connect-MsolService -Credential $UserCredential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking


Set-MailboxAutoReplyConfiguration -Identity $user -AutoReplyState Enabled -ExternalMessage $message -InternalMessage $message





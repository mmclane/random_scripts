#Set-ExecutionPolicy RemoteSigned
$UserCredential = Get-Credential
Import-Module MSOnline
Connect-MsolService -Credential $UserCredential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking



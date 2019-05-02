#####################
#Set-myCredential.ps1
Param($File)
$Credential = Get-Credential
$credential.Password | ConvertFrom-SecureString | Set-Content c:\temp\creds
#####################
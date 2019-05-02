param($email, $password)
Set-MsolUserPassword -UserPrincipalName $email -NewPassword $password -ForceChangePassword $False
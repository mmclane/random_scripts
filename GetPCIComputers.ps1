$getstr = "https://m-t-svc01.adsroot.itcs.umich.edu/deploywebsvc/ad.asmx/GetGroupMemberNames?Groupname=euc-pci-computers"

#$secpasswd = ConvertTo-SecureString "password" -AsPlainText -Force
#$mycreds = New-Object System.Management.Automation.PSCredential ("account", $secpasswd)

$mycreds = Get-Credential

$return = Invoke-WebRequest -Uri $getstr -SessionVariable FB -Credential $mycreds

[xml]$xml = $return.Content

$xml.Arrayofsting.string

foreach($i in $xml.ArrayOfString.string){
    write-host $i
}
Function Config-DNS(){
	#Set forwarders
    dnscmd.exe localhost /ResetForwarders 8.8.8.8
    #Forward Lookup
    dnscmd.exe localhost /ZoneAdd test.local /primary
    dnscmd.exe localhost /config test.local /AllowUpdate 1 #Allow dynamic updates
    #Reverse Lookup
    dnscmd.exe localhost /zoneadd 0.168.192.in-addr.arpa /primary
    dnscmd.exe localhost /config 0.168.192.in-addr.arpa /AllowUpdate 1
}

Function Config-DHCP(){
    #DHCP Scope Options
    $DNSDomain="test.local"
    $ip=get-WmiObject Win32_NetworkAdapterConfiguration|Where {$_.Ipaddress.length -gt 1} #Get Local IP Address
    $DNSServerIP = "$ip.ipaddress[0]" 
    $scope="192.168.1.0"
    $Subnet="255.255.255.0"
    $Router="192.168.1.1"
	
	#Add security groups
    netsh dhcp add securitygroups
    
    #Create Scope
    netsh dhcp server localhost add scope $scope $Subnet "test.local"

    #exclude first 50
    netsh dhcp server localhost scope $scope add excluderange 192.168.1.1 192.168.1.50

    #Set Default Gateway option
    netsh dhcp server localhost scope $scope set optionvalue 003 IPADDRESS $Router
    #Set DNS Option
    netsh dhcp server localhost scope $scope set optionvalue 015 IPADDRESS $DNSServerIP

    #Set scope as active
    netsh dhcp server localhost scope $scope set state 1

    Restart-service dhcpserver
}

#####################
#
# Main
#
#####################

#Install Windows Features if need
Get-WindowsFeature -name DNS| Where-Object {$_.Installed -match “False”} | add-windowsfeature #Install-WindowsFeature -IncludeManagementTools
Get-WindowsFeature -name DHCP| Where-Object {$_.Installed -match “False”} | add-windowsfeature #Install-WindowsFeature -IncludeManagementTools

#Configure Services
Config-DNS
Config-DHCP

#Get list of servers
$servers = Get-Content C:\temp\servers.txt

#Create DNS and DHCP records for each server.
foreach($server in $servers){
    $serverArray = $server.split(",")
    $name = $serverArray[0]+".test.local"
    $mac = $serverArray[1]
    $ip = $serverArray[2]
    
    Write-host "$name - $mac - $ip"

    dnscmd localhost /recordadd test.local $name /CreatePTR A $ip
   
    netsh dhcp server localhost scope $scope add reservedip $ip $mac $name 
}

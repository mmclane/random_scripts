
function validate-user($user){
    $URL = "http://euc-t-scorch1.adsroot.itcs.umich.edu/adactions/ad.asmx/DoesUserExist?LogonID=$user"
    $response = invoke-RestMethod -Uri $url

    if($response.boolean.'#text' -eq "true"){return $true}else{return $false}
}


function set-compdescription($computer, $description){
    $URL = "http://euc-t-scorch1.adsroot.itcs.umich.edu/adactions/ad.asmx/SetComputerDescription?ComputerName=$computer&ComputerDescription=$description"
    $response = invoke-RestMethod -Uri $url

    if($response.boolean.'#text' -eq "true"){return $true}else{return $false}
}



function move-computertoOU($computer, $OU){

    $OUPath = "ou=$ou,ou=windows,ou=computers,ou=euc,ou=administration,ou=umich,dc=adsroot,dc=itcs,dc=umich,dc=edu"
    $URL = "http://euc-t-scorch1.adsroot.itcs.umich.edu/adactions/ad.asmx/MoveComputerToOU?ComputerName=$computer&OUPath=$OUPath"
    $response = invoke-RestMethod -Uri $url

    if($response.boolean.'#text' -eq "true"){return $true}else{return $false}
}

function get-OUs(){
    $ParentOU = "ou=windows,ou=computers,ou=euc,ou=administration,ou=umich,dc=adsroot,dc=itcs,dc=umich,dc=edu"
    $URL = "http://euc-t-scorch1.adsroot.itcs.umich.edu/adactions/ad.asmx/GetOUs?ParentPath=$ParentOU&Level=0"
    $response = invoke-RestMethod -Uri $url

    return $response.ArrayOfOU.OU
}


function set-localadmin($user, $computer){
   $pass = convertto-securestring -String "OXldoZC50CZ9KLgJxB88" -asplaintext -force
	$Creds = new-object -typename System.Management.Automation.PSCredential -argumentlist "umroot\euc-scorch-action", $pass	
	
	$ADPath = "ou=groups,ou=euc,ou=products,ou=umich,dc=adsroot,dc=itcs,dc=umich,dc=edu"
	
	New-ADGroup -path $ADPath -Name $computer -GroupScope "Global" -Credential $Creds  
    Add-ADGroupMember -Identity $computer -Members $user -Credential $Creds 
}


set-localadmin -user "mclanem" -computer "m3-test"


#move-computertoOU -computer $env:COMPUTERNAME -OU "Virtual Machines"
#set-compdescription -computer "M-CNU317BTMC" -description "mclanem"
#validate-user -user "mclanem"
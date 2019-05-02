#$gpresult = get-content -path c:\scripts\gpresult.txt

$gpresult = gpresult /scope computer /z
Add-content -path c:\apps.csv -value "Application,Version,GPO,Source"
$InInstall = 0
$count = 0
foreach ($i in $gpresult){
  if ($i.Contains("Software Installations")){$InInstall = 1}
  if ($InInstall -eq 1){
    if ($i.contains("Name:   ")){
	$AppName = $i.substring(34,$i.length-34)
	$AppGPO = $gpresult[$count-1].substring(17,$gpresult[$count-1].length-17)	
	$AppVer = $gpresult[$count+1].substring(34,$gpresult[$count+1].length-34)	
	#$AppDeployState = $gpresult[$count+2].substring(34,$gpresult[$count+2].length-34)
	$AppSource = $gpresult[$count+3].substring(34,$gpresult[$count+3].length-34)
	#$AppAutoInstall = $gpresult[$count+4].substring(34,$gpresult[$count+4].length-34)
	#$AppOrigin = $gpresult[$count+4].substring(34,$gpresult[$count+4].length-34)
	

	
	$Line = $Appname +","+$AppVer+","+$AppGPO+","+$AppSource
	if ($Object -eq $null){$object = $line  }
	Else {$object = $object + ":" + $line}
	
	}
  
  }
  if ($i.Contains("Startup Scripts")){$InInstall = 0}
  $count ++
}

if ($object -eq $null){$apps = "No Assigned Applications"}
Else{
$myarray = $Object.split(":")
foreach ($i in $myarray){add-content -path c:\apps.csv -value $i}


$Apps = import-csv c:\apps.csv
}

del c:\apps.csv
$apps


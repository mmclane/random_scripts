function Get-StateSize($state){
	if((Test-Path $state) -eq $true){
	    $file = Get-Item $state
	    $size = $file.length
        $unit = "bytes"
        if($size -gt 1024){
            $size = $file.length/1kb
            $unit = "kb"
        }
        if($size -gt 1024){
            $size = $file.length/1mb
            $unit = "mb"
        }
        if($size -gt 1024){
            $size = $file.length/1gb
            $unit = "gb"
        }
	
        $size = [System.Math]::Round($size,2)
        return [string]$size+" $unit"
    }Else{return "Unknown"}
    
}


$output = Get-StateSize("C:\UserState\test2\Datastore\USMT\USMT.mig")
#$output = Get-StateSize("d:\en_windows_7_enterprise_x64_dvd.iso")
write-host "Size: $output"

$log = "c:\temp\ulib-robocopy-04-10-14_06_00-00.log"

Remove-Item c:\temp\4-10-2014-ULIB-Stuff.txt


$content = Get-Content $log # -totalcount 500

foreach ($line in $content){
    If($line.Contains("Started :")){
        $currentline = $line.ReadCount
        $sourceline = [int]$currentline + 2
            
        $line | out-file -FilePath c:\temp\4-10-2014-ULIB-Stuff.txt -append 
    }
    If($line.Contains("Ended :")){
        "$line`n" | out-file -FilePath c:\temp\4-10-2014-ULIB-Stuff.txt -append 
        #write-host $line
    }
    if($line.ReadCount -eq $sourceline){
        $line | out-file -FilePath c:\temp\4-10-2014-ULIB-Stuff.txt -append 
    }
    if($line.ReadCount -eq $sourceline+1){
        $line | out-file -FilePath c:\temp\4-10-2014-ULIB-Stuff.txt -append 
    }
 

}


$newlog = get-content c:\temp\4-10-2014-ULIB-Stuff.txt
foreach($l in $newlog){Write-host $l}
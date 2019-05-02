function Execute-HTTPPost(){

    param([string]$target = $null)
    
    $webRequest = [System.Net.WebRequest]::Create("$target"+"?"+"$post")
    $webRequest.ContentType = "text/html"
    $PostStr = [System.Text.Encoding]::UTF8.GetBytes($Post)
    $webrequest.ContentLength = $PostStr.Length
    $webRequest.ServicePoint.Expect100Continue = $false

    #$webRequest.Credentials = New-Object System.Net.NetworkCredential -ArgumentList $username, $password 

    #$webRequest.PreAuthenticate = $true
    $webRequest.Method = "POST"
    $requestStream = $webRequest.GetRequestStream()
    $requestStream.Write($PostStr, 0,$PostStr.length)
    $requestStream.Close()

    #Response

    [System.Net.WebResponse]$resp = $webRequest.GetResponse();
    $rs = $resp.GetResponseStream();
    [System.IO.StreamReader]$sr = New-Object System.IO.StreamReader -argumentList $rs;
    [string]$results = $sr.ReadToEnd();
    return $results;
 }


 Function PostStatus(){
    Param([string]$taskID = $null, [string]$phase = $null, [string]$task = $null)
     $URL = "http://webapps.ccs.itd.umich.edu/mibuilds/windowsreload_post.php"
     
     $computername = (Get-Item ENV:computername).value

     $post = "active_directory_domain_name=$computername&state=$phase&task_sequence_id=$taskid&active_task=""$task"""

     Write-Host $post

     Execute-HTTPPost $URL
}

PostStatus -taskID "Test" -phase "TestPhase" -task "TEST task item"
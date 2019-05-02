function Create_DFSLink_group($subou, $name){
    #adsroot.itcs.umich.edu/UMICH/Administration/EUC/Resources/EUC Security/Permissions/DFSLinks
    $rootOUDN = "ou=dept,ou=dfslinks,ou=permissions,ou=euc security,ou=resources,ou=euc,ou=administration,ou=umich,dc=adsroot,dc=itcs,dc=umich,dc=edu"
    $deptOU = "ou=$subou,$rootOUDN"

    #check for subou
    if([adsi]::Exists("LDAP://$deptOU") -eq $false){New-ADOrganizationalUnit -Name $subou -Path $rootOUDN}

    #check for group
    $Group = Get-ADGroup -Filter {SamAccountName -eq $name}
    if($group){Write-Host "AD Group $name Exists"}
    else{
        new-adgroup -path $deptOU -Name $name -GroupScope DomainLocal
        Write-Host "Created group $name"    
    }
}


function Create_DFS_Link($DFSRoot,$folder, $dept, $target, $abe = "none"){
    $dfspath = 	"$DFSRoot\$folder"

    if(Test-Path $dfspath){Write-Host "$folder link exists: $dfspath"}
    Else{
        Write-host "Creating DFS Folder : $folder"    
	    New-DfsnFolder -Path $dfspath -TargetPath $target -Description $target | format-table path,Description,State
    }

    Write-host "Applying ABE permissions for $abe"
	#http://technet.microsoft.com/en-us/library/dd759150.aspx

	if($abe -ne "none"){
       
       Create_DFSLink_group -subou $dept -name "euc-viewdfs-$folder"
              
        #Grant ABE access to accounts.  This includes the specified account and the admin group.
       # Grant-DfsnAccess -Path $dfspath -AccountName $abe | Out-Null
       # Grant-DfsnAccess -Path $dfspath -AccountName "euc-serviceadmins-dfs" | Out-Null
        #Set link to use explicet access permissions
       # dfsutil property acl grant $dfspath $abe:F protect | Out-Null
        #return access rights.
       # Get-DfsnAccess -Path $dfspath
    }else{Write-Host "No ABE group specified."}
}


########################################################
# Setup:  Change the following variables for each dept

$xlsfile = "c:\temp\ULIBdrivemappings.csv"
$dept = "ulib"

########################################################


$DFS_Root = "\\umroot\mws\support\testing\$dept"
$source = Import-Csv $xlsfile


foreach( $item in $source){
Write-host "`n----------------------`n"
$foldername = $item.Label
$Pointto = $item.Path
$abe = $item.Group

if($abe -eq ""){Create_DFS_Link -DFSRoot $DFS_Root -folder $foldername -target $Pointto}
Else{Create_DFS_Link -DFSRoot $DFS_Root -folder $foldername -target $Pointto -abe $abe}
}




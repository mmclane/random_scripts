Param( 
$originalComp =" ", 
$newComp = " " 
) 


Function Get-MyModule { 
    Param([string]$name) 
    if(-not(Get-Module -name $name)){  
        if(Get-Module -ListAvailable | Where-Object { $_.name -eq $name }){  
            Import-Module -Name $name  
            $true 
        } #end if module available then import 
        else { $false } #module not available 
        } # end if not module 
    else { $true } #module already loaded 
}

Function Get-CompOU { 
    Param($identity) 

    $comp = Get-AdComputer -Identity $identity  
    $dnArray = ($comp.DistinguishedName).Split(",")

    Foreach($e in $dnArray){ 
        if($e -ne $dnArray[0]){$ou += ","+$e}
    }
    Return $ou.Substring(1) 

    #Return $OU
}


Function Get-GroupsToMigrate { 
    Param($identity) 

    $array = @() 
    $groups = Get-AdComputer -Identity $identity -property "MemberOf"  
    Foreach($group in $groups.memberOf){ 
    #    $reply = Read-Host -Prompt "add group $($group) `r`ny / n" 
    #    if($reply -match "y") {$array +=$group} 
        $array += $group
    } #end foreach 
    Return $array 
}


Function Comp-Exists($compname){
    $c = $(try {Get-ADComputer $compname} catch {$null})
    Return ($c -ne $null)
}


# *** ENTRY POINT TO SCRIPT *** 
If(-not (Get-MyModule -name "ActiveDirectory")) { exit } #Load AD Module

#$originalComp = "m-cnd2410dh5"
#$newComp = "m-m3copytest"

If(Comp-Exists $originalComp){
    If(Comp-Exists $newComp)  #If new computer object already exists, delete it
    {
        Write-Host "$newComp object already exists.  Deleting ..."
        Remove-ADComputer $newComp
    }
    
    $OU = Get-CompOU $originalComp
    Write-Host "Creating $newComp @ $OU"
    New-ADComputer -name $newComp -Path $OU #Create new computer object.

    $groups = Get-GroupsToMigrate -identity $originalComp  #Get original computer's group memberships
    Get-ADComputer -Identity $newComp | Add-ADPrincipalGroupMembership -MemberOf $groups  #Add memberships to new computer object.


}Else{Write-Host "$orginalComp doesn't exist in UMROOT"}
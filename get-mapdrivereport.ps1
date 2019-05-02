# "AX"
param($dept = "FIN")

$depPrefix = $dept

Import-Module GroupPolicy

[xml]$report = Get-GPOReport -Name "EUC Windows $depPrefix Drive Mappings" -ReportType xml


$filters = @()

$report.GPO.User.ExtensionData.Extension.DriveMapSettings.Drive | Foreach-Object {
    
    $uid = $_.uid
    $Name = $_.name
    $GPOSettingOrder = $_.GPOSettingOrder
    $Label = $_.Properties.label
    $Path = $_.Properties.path
    $action = $_.Properties.action
    
    $_.Filters.FilterGroup | ForEach-Object{
        $Object = "" | Select GPOSettingOrder,DriveLetter,Label,Path,Action,bool,not,GroupName,FilterCollection,userContext,primaryGroup,localGroup,uid
        $Object.uid = $uid
        $Object.DriveLetter = $Name
        $Object.GPOSettingOrder = $GPOSettingOrder
        $Object.Label = $Label
        $Object.Path = $Path
        $Object.Action = $action


        $Object.GroupName = $_.Name
        $Object.bool = $_.bool
        $Object.not = $_.not
        $Object.FilterCollection = 0
        $Object.userContext = $_.userContext
        $Object.primaryGroup = $_.primaryGroup
        $Object.localGroup = $_.localGroup

        $filters += $Object
    }

    If ($_.Filters.Filtercollection.Filtergroup -ne $null){
        $_.Filters.Filtercollection.Filtergroup | ForEach-Object{
            $Object = "" | Select GPOSettingOrder,DriveLetter,Label,Path,Action,bool,not,GroupName,FilterCollection,userContext,primaryGroup,localGroup,uid
            $Object.uid = $uid
            $Object.DriveLetter = $Name
            $Object.GPOSettingOrder = $GPOSettingOrder
            $Object.Label = $Label
            $Object.Path = $Path
            $Object.Action = $action


            $Object.GroupName = "( "+ $_.Name + " )"
            $Object.bool = $_.bool
            $Object.not = $_.not
            $Object.FilterCollection = 1
            $Object.userContext = $_.userContext
            $Object.primaryGroup = $_.primaryGroup
            $Object.localGroup = $_.localGroup

            $filters += $Object
    
        }
    }
}

$filters | Select GPOSettingOrder,label, Path |format-table -AutoSize

$filters | Export-Csv -Path "c:\temp\$depPrefix-Mapped-Drive-Report.csv"

invoke-item "c:\temp\$depPrefix-Mapped-Drive-Report.csv"
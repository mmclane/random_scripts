###########################
# UHR-pstfilemove.ps1
# Written: Matt McLane
#
# This script will scan the C:\temp directory for any .pst files and move them to a subfolder of C:\Save
# The subfolder is called pstfilesFromTemp-{date}
# Folder structures are retained to avoid duplicate naming conflicts.
#
###########################

#Get List of all PST files in C:\temp
$psts = Get-ChildItem c:\temp -Recurse | Where-Object {$_ -like "*.pst"}
if($psts -ne $null){
    foreach ($f in $psts){
        #Get the source files full name and directory
        $source = $f.FullName
        $sourcedir = $f.DirectoryName
        
        #Create name for the folder where the files will be put.
        $d = (date).toShortDateString()
        $subfolder = ("pstfilesFromTemp-$d").replace("/","")
        $dest = $sourcedir.replace("C:\temp","C:\save\$subfolder")
        
        Write-Host "Moving: $source -> $dest"
        #create the destination directory if it doesn't exsist
        mkdir $dest -Force | Out-Null
        
        #Move the files
        Move-Item -Path $f.FullName -Destination $dest -Force | Out-Null
        }
}
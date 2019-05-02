
Function Get-Compare($user, $logfile){
    "----- $user -----" >> $logfile
    #$oldprofile = "\\ulib-storage.m.storage.umich.edu\ulib-storage\Staff\Home\$user"
    $oldprofile = "\\ulib-storage.m.storage.umich.edu\ulib-storage\Staff\HomeArchive\$user"

    $newprofile = "\\ulib-users.m.storage.umich.edu\ulib-users\homefolders\$user\Documents"

    $olddir = dir $oldprofile -Recurse
    $newdir = dir $newprofile -Recurse

    $compareResult = Compare-Object $olddir $newdir | Where {$_.sideindicator -eq "<="} 
    
    $compareResult.InputObject.directoryname | Out-File -FilePath $logfile -Append
}

$usernames = "amuro,balaj,bdede,brownash,dmcw,dmprice,ekflanag,ellenkw,emustard,epeiffer,esaran,escobarr,gendres,gnichols,hkoustov,hnhampt,jaglover,jaheim,jennywri,jrn,jrtalley,kfolger,kmsom,kstuart,layers,lene,mrosic,nrobins,rabraham,rutter,rwwhaley,sarabahn,selliker,sinilga,thubbard,vgulko,vickik,weichen,wheigel"

$array = $usernames.Split(",")

Remove-Item c:\temp\compare.log

Foreach($u in $array){Get-Compare -user $u -logfile "c:\temp\compare.log"}




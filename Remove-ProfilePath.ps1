#logon to wlmsts
#Run the Quest ActiveRoles Management Shell for Active Directory
#put the uniquenames the file userlist.csv
#run the script.


#This comes the properties of the OU in ADUC.  
#Copy paste the cononical name from the object tab.

$OU = "adsroot.itcs.umich.edu/UMICH/Accounts/LSA/Statistics"


Get-QADuser -SearchRoot $OU | set-qaduser -ProfilePath "$null" 

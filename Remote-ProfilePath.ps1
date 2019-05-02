#logon to wlmsts
#Run the Quest ActiveRoles Management Shell for Active Directory
#put the uniquenames the file userlist.csv
#run the script.



import-csv userlist.csv | foreach {get-qaduser $_ | set-qauser -ProfilePath "$null"
 
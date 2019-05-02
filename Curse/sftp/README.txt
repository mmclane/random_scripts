For this stand alone puppet module I have made the following assumptions

- You have configured chocolatey on the server.  If not please run the command listed below from an elevated cmd prompt

- You have placed the Module folder in c:\temp (You just need to modify the command below to change it)

Run the following command to install FileZilla Server, create the folder c:\SFTPRoot, and configure the server.  The user account is curse with the password curseinc: puppet apply c:\temp\sftp\test\server.pp --modulepath=c:\temp 

Given more time I would probably turn the FileZilla-Server.xml file into a template so that this could be much more flexible.  I also would try to understand the environment this was going to be running in to see if I need to configure other setting differently, like passive mode for instance.



Chocolatey Install:
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

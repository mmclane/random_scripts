I accepted the following challanges:

1. Create and configure DHCP and DNS on a fresh Windows 2012 Server. Create entries in DNS and DHCP for a small web farm. For example, 3 web servers a database server and a caching server.

4. Write a script to idempotently create an LVM partition and mount it, script should accept parameters for the device and the target folder to mount it on.  Example command:  createlvm /dev/sdb [/dev/dbc] /media/data

5. Create either a SFTP Server or IIS Website using a Configuration Management System such as Chef, Puppet or Powershell DSC.  This should create a functional system including any applicable logins, users and content. This must be applicable in a stand-alone fashion without a server to run against.  Best practices and security implications will be considered.

I chose these challenges for a number of reasons.  Over the past week I have been teaching myself and testing Puppet in a test lab.  I used these challanges as an opportunity to try out a few things I had been wanting to play with.  First, I used challange 1. to test out pushing a powershell script through Puppet.  I was able to get the DNS correctly configured, but I am not 100% certain on DHCP since I couldn't safely test it in my test lab.  Also, I didn't have Server 2012 available so some of the commmand and methods I used are not the latest Powershell options.  I do however believe my script will work.

Second, I select to write a bash script to crate an LVM partition largely because I have been working with Linux fairly heavily over the past few weeks and I wanted to try my hand at bash shell scripting again.  It has been a very long time since I have written one.

Finally, I used challenge #5 as an opportunity to check out and play with the chocolatey module in Puppet.  This is why I had it install and configure Filezilla Server instead of using something built into the opportating system.  There is a lot more I could do with this module including converting the configuration file to a template and learning Hiera to secure the account passwords, but that would have taken more time then I had to complete the challenges.


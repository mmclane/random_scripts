class sftp::server{
        #Make sure Filezilla server is installed
        package { 'filezilla.server':
                ensure => installed,
		provider => 'chocolatey',

        }

        #Make sure c:\sftproot is present
        file { "c:\\sftproot":
                ensure => "directory",
        }
	
	service{ "FileZilla Server":
		ensure => "running",
		enable => "true",
		require => Package['filezilla.server'],
	}

	file {"FileZilla Server.xml":
		path => 'c:\\Program Files (x86)\\FileZilla Server\\FileZilla Server.xml',
		ensure => file,
		source => "puppet:///modules/sftp/FileZilla-Server.xml",
		require => Package['filezilla.server'],
		source_permissions => ignore,
		notify => Service["FileZilla Server"],
	}
}

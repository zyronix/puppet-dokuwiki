# Changelog

## Release 0.3.1

**Features**
 - Able to specify the ssl_ca option
**Bugfixes**
 - None
**Known Issues**
 - Only runs on Debian / Ubuntu

## Release 0.3.0

**Features**
 - SSL support, either selfsigned or specify the paths for cert and key
 - Specify if the module should manage the local.php and users.auth.php file
 - Now also manages the htaccess file
 - Added userewrite option and auto provisioning of the requirements
**Bugfixes**
 - Closed default ACL was not working
 - Default apache options were insecure
**Known Issues**
 - Only runs on Debian / Ubuntu

## Release 0.2.1

**Features**
 - None
**Bugfixes**
 - If more than one ACL was supplied, only the first was working.
**Known Issues**
 - Only runs on Debian / Ubuntu

## Release 0.2.0

**Features**
 - More complex installation, it basically runs the install.php file
**Bugfixes**
 - Non
**Known Issues**
 - Only runs on Debian / Ubuntu

## Release 0.1.0

**Features**
 - Initial release, simply only installs dokuwiki
**Bugfixes**
 - Non
**Known Issues**
 - Only runs on Debian / Ubuntu

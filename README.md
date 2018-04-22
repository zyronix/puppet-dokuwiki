
# dokuwiki

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with dokuwiki](#setup)
    * [What dokuwiki affects](#what-dokuwiki-affects)
    * [Beginning with dokuwiki](#beginning-with-dokuwiki)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

This module manages and install dokuwiki! (https://https://www.dokuwiki.org/)

Currently it is still in development. There is another dokuwiki module on the forge, but it is not being maintained and it is not forkable because no license is supplied.

This module should: install, manage (config files), secure and offer enough functionality to run dokuwiki in production. 

Limitations: 
  * Tested and developed for Debian 9 (plans are to support more OSses). 
  * By default it uses apache as a webserver, but this can be disabled

If you are missing any feature in this module, please open an issue or write a pull request.

## Setup
### What dokuwiki affects
By default dokuwiki affects:
 - Dokuwiki directory
 - Apache service and config
 - PHP Config

### Beginning with dokuwiki
To install Dokuwiki declare the dokuwiki class:

``` puppet
class { 'dokuwiki': 
  wiki_title => 'Awesome wiki!',
}
```

 - This will install dokuwiki with the latest tar.gz from the doku wiki website (stable version). 
 - Also it will install apache and php. 
 - Create an apache vhost pointing the the extracted dokuwiki folder.
 - Configure dokuwiki to NOT use authentication.


## Usage
A beter way to use the dokuwiki is of course to secure it more and not use the default completly open schema. For this you can specify the 'default_acl' option. See #reference for more details on this option, but in general a more sure configuration looks like this:

```puppet
 class {'dokuwiki':
   wiki_title => 'Wiki',
   admin_user => 'admin',
   admin_passwordhash => 'dokuwiki$1$4fd0ad31$.cId7p1uxI4a.RcrH81On0', # Which is hashed and salted: admin
   default_acl => 'public',
 }
```

It is not recommanded by dokuwiki to modify the ACLs outside of the dokuwiki webinterface. So, by default this module to not overwrite any acls; it only supplies one on installation.

To create any additional users: user the dokuwiki::user defined type:

```puppet
   dokuwiki::user { 'admin':
     passwordhash => '$1$4fd0ad31$.cId7p1uxI4a.RcrH81On0',
     real_name    => 'admin',
     email        => 'root@localhost',
     groups       => ['user', 'admin'],
   }
```

## Reference
## Reference

### Classes
* [`dokuwiki`](#dokuwiki): This module manages and install dokuwiki.
* [`dokuwiki::config`](#dokuwikiconfig): Main configuration of dokuwiki
* [`dokuwiki::install`](#dokuwikiinstall): Main installation of dokuwiki
* [`dokuwiki::params`](#dokuwikiparams): Default variable logic for dokuwiki
* [`dokuwiki::service`](#dokuwikiservice): Configures services required by dokuwiki
### Defined types
* [`dokuwiki::acl`](#dokuwikiacl): Create ACL rules in the acl.auth.php configuration file
* [`dokuwiki::user`](#dokuwikiuser): Creates local user in the users.auth.php file
### Classes

#### dokuwiki

dokuwiki

This module manages and install dokuwiki.

##### Examples
###### 
```puppet
class { 'dokuwiki':
  wiki_title => 'My awesome dokuwiki'
}
```


##### Parameters

The following parameters are available in the `dokuwiki` class.

###### `wiki_title`

Data type: `String`

The title of this wiki, will be displayed on all the pages.

###### `admin_user`

Data type: `String`

The username of the admin user, can be left empty if default_acl is open

Default value: $dokuwiki::params::admin_user

###### `admin_passwordhash`

Data type: `String`

The password hash of the admin user. To generate the hash use the mkpasswd, which is part of the whois package. Generate the password using the following command: 'mkpasswd -m sha-512 -s <<< YourPass'

Default value: $dokuwiki::params::admin_password

###### `admin_real_name`

Data type: `String`

The real name of the admin user

Default value: $dokuwiki::params::admin_real_name

###### `admin_email`

Data type: `String`

The e-mail adres of the admin user

Default value: $dokuwiki::params::admin_email

###### `admin_groups`

Data type: `Array`

An array of group for the admin user.

Default value: $dokuwiki::params::admin_groups

###### `manage_webserver`

Data type: `Boolean`

If enabled (default), this module will also manages and installs apache

Default value: $dokuwiki::params::manage_webserver

###### `manage_php`

Data type: `Boolean`

If enabled (default), this module also manages and installs php

Default value: $dokuwiki::params::manage_php

###### `lang`

Data type: `String`

The language of the dokuwiki

Default value: $dokuwiki::params::lang

###### `license`

Data type: `String`

The default license used for all the content placed on the dokuwiki

Default value: $dokuwiki::params::license

###### `useacl`

Data type: `Enum[0, 1]`

If set to 1 the ACL module is enable and the dokuwiki will use the acl.auth.php config file

Default value: $dokuwiki::params::useacl

###### `default_acl`

Data type: `Enum['public', 'open', 'closed']`

Specifiy the default acl. Open means: anyone can edit, Public means: anyone can view; users can edit, Closed means: only users can view and edit

Default value: $dokuwiki::params::default_acl

###### `replace_acl`

Data type: `Boolean`

If set, this module will replace contents of the ACL, possibly revering changes done in the webinterface. Dokuwiki does not recommend this.

Default value: $dokuwiki::params::replace_acl

###### `superuser`

Data type: `String`

This variable determines which user or group defines the super admins

Default value: $dokuwiki::params::superuser

###### `disableactions`

Data type: `String`

This variable can be used to disable specific actions: like registering. See https://www.dokuwiki.org/config:disableactions for more information

Default value: $dokuwiki::params::disableactions


#### dokuwiki::config

dokuwiki::config

Main configuration of dokuwiki

##### Examples
###### 
```puppet
This class should not be called
```


#### dokuwiki::install

dokuwiki::install

Main installation of dokuwiki

##### Examples
###### 
```puppet
This class should not be called
```


#### dokuwiki::params

dokuwiki::params

Default variable logic for dokuwiki

##### Examples
###### 
```puppet
This class should not be called
```


#### dokuwiki::service

dokuwiki::service

Configures services required by dokuwiki

##### Examples
###### 
```puppet
This class should not be called
```


### Defined types

#### dokuwiki::acl

dokuwiki::acl

Create ACL rules in the acl.auth.php configuration file

##### Examples
###### 
```puppet
dokuwiki::acl { 'acl_line':
  user       => '*',
  group      => '@ALL',
  permission => '8',
}
```


##### Parameters

The following parameters are available in the `dokuwiki::acl` defined type.

###### `user`

Data type: `String`

Specify the user for which this ACL rule applies. Use '*' to apply rule to all users.

###### `group`

Data type: `String`

Specify the group for which this ACL rule applies. Start the group name with the '@' sign and use '*' to apply rule to all groups.

###### `permission`

Data type: `Numeric`

Specify the permission for this ACL rule. Possible permissions are: 1 for read, 2 edit, 4 create, 8 upload. See https://www.dokuwiki.org/acl for more information.


#### dokuwiki::user

dokuwiki::user

Creates local user in the users.auth.php file

##### Examples
###### 
```puppet
dokuwiki::user { 'admin':
  passwordhash => '$1$4fd0ad31$.cId7p1uxI4a.RcrH81On0',
  real_name    => 'admin',
  email        => 'root@localhost',
  groups       => ['user', 'admin'],
}
```


##### Parameters

The following parameters are available in the `dokuwiki::user` defined type.

###### `passwordhash`

Data type: `String`

The password hash for the user. To generate the hash use the mkpasswd, which is part of the whois package. Generate the password using the following command: 'mkpasswd -m sha-512 -s <<< YourPass'

Default value: ''

###### `real_name`

Data type: `String`

The real name of the user, used to display the name of the user when pages are edit or created.

Default value: ''

###### `email`

Data type: `String`

The e-mail address of the user.

Default value: ''

###### `groups`

Data type: `Array`

The groups of the user.

Default value: []

###### `login`

Data type: `String`

The username of the user to create, default to the $name parameter.

Default value: $name

## Limitations
Currently the module is in development. I only tested it on Debian, but I aim to support more versions.

## Development
To help development, please make sure you use PDK for the development of new feature and create / run tests.
Run the acc tests with the follow command:
```
pdk bundle
pdk bundle exec rake spec_prep
pdk bundle exec rspec spec/defines/user_spec.rb
pdk bundle exec rake beaker
```


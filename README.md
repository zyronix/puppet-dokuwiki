
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
  * Tested and developed for Debian 9 (there are plans to support more OSses). 
  * By default it uses apache as a webserver, but this can be disabled.

If you are missing any features in this module, please open an issue or write a pull request.

## Setup
### What dokuwiki affects
By default dokuwiki affects:
 - Dokuwiki directory
 - Apache service and config
 - PHP Config
 - Dokuwiki configuration files (local, acl, users)

### Beginning with dokuwiki
To install Dokuwiki declare the dokuwiki class:

``` puppet
class { 'dokuwiki': 
  wiki_title => 'Awesome wiki!',
}
```

 - This will install dokuwiki with the latest tar.gz from the dokuwiki website (stable version).
 - Also it will install apache and php.
 - Create an apache vhost pointing the the extracted dokuwiki folder.
 - Configure dokuwiki to NOT use authentication.


## Usage
A beter way to use the dokuwiki is of course to secure it (enable ACLs) and not use the default completly open schema. For this you can specify the 'default_acl' option. See #references for more details on this option, but in general a more secure configuration looks like this:

```puppet
 class {'dokuwiki':
   wiki_title         => 'Wiki',
   admin_user         => 'admin',
   admin_passwordhash => '$1$4fd0ad31$.cId7p1uxI4a.RcrH81On0', # Which is hashed and salted: admin
   default_acl        => 'public',
 }
```

It is not recommended by dokuwiki to modify the ACLs outside of the dokuwiki webinterface. So, by default this module does not overwrite any acls; it only supplies one for installation.

To create any additional users: use the dokuwiki::user defined type:

```puppet
   dokuwiki::user { 'admin':
     passwordhash => '$1$4fd0ad31$.cId7p1uxI4a.RcrH81On0',
     real_name    => 'admin',
     email        => 'root@localhost',
     groups       => ['user', 'admin'],
   }
```

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
And update the reference documentation when new options have been added:

```
puppet strings generate --format markdown
```
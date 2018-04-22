
# dokuwiki

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with dokuwiki](#setup)
    * [What dokuwiki affects](#what-dokuwiki-affects)
    * [Setup requirements](#setup-requirements)
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
class { 'dokuwiki': }
```

 - This will install dokuwiki with the latest tar.gz from the doku wiki website (stable version). 
 - Also it will install apache and php. 
 - Create an apache vhost pointing the the extracted dokuwiki folder.


## Usage
TODO

## Reference
TODO

## Limitations
Currently the module is in development. I only tested it on Debian, but I aim to support more versions.

## Development
To help development, please make sure you use PDK for the development of new feature and create / run tests.
Run the acc tests with the follow command:
```
pdk bundle
pdk bundle exec rake beaker
```

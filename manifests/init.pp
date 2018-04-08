# dokuwiki
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include dokuwiki
# 
# @param manage_webserver If enabled (default), this module will also manages and installs apache
# @param manage_php If enabled (default), this module also manages and installs php
class dokuwiki (
  $manage_webserver = $dokuwiki::params::manage_webserver,
  $manage_php = $dokuwiki::params::manage_php,
) inherits dokuwiki::params {
  class {'dokuwiki::install':}
  -> class {'dokuwiki::config':}
  -> class {'dokuwiki::service':}
}

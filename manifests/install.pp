# dokuwiki::install
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include dokuwiki::install
class dokuwiki::install {
  $manage_webserver = $dokuwiki::manage_webserver
  $manage_php = $dokuwiki::manage_php

  if $manage_webserver {
    class {'apache':
      mpm_module => 'prefork',
    }
  }

  if $manage_php {
    class {'php':
    }
  }

  if $manage_php and $manage_webserver {
    class {'apache::mod::php':
    }
  }
}

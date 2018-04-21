# dokuwiki::params
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include dokuwiki::params
class dokuwiki::params {
  $manage_webserver = true
  $manage_php = true

  case $facts['os']['name'] {
    /^(Debian|Ubuntu)$/: {
      $php_version = '7.0'
      $install_path = '/var/www'
      $user = 'www-data'
      $group = 'www-data'
    }
    default: {
      fail('OS not supported')
    }
  }

  $tmp_dir = '/tmp'
  $download_link = 'https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz'
  $archive = 'dokuwiki-stable.tgz'
}

# dokuwiki::params
#
# Default variable logic for dokuwiki
#
# @summary Default variable logic for dokuwiki
#
# @example
#   This class should not be called
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

  $lang = 'en'
  $license = 'cc-by-sa'
  $useacl = 1
  $superuser = '@admin'
  $disableactions = ''
  $admin_password = ''
  $admin_user = ''
  $admin_real_name = ''
  $admin_email = ''
  $admin_groups = ['admin', 'user']
  $default_acl = 'open' # public or closed
  $replace_acl = false
}

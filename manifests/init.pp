# dokuwiki
#
# This module manages and install dokuwiki.
#
# @summary This module manages and install dokuwiki.
#
# @example
#   class { 'dokuwiki': 
#     wiki_title => 'My awesome dokuwiki'
#   }
# 
# @param wiki_title The title of this wiki, will be displayed on all the pages.
# @param admin_user The username of the admin user, can be left empty if default_acl is open
# @param admin_passwordhash The password hash of the admin user. To generate the hash use the mkpasswd, which is part of the whois package. Generate the password using the following command: 'mkpasswd -m sha-512 -s <<< YourPass'
# @param admin_real_name The real name of the admin user
# @param admin_email The e-mail adres of the admin user
# @param admin_groups An array of group for the admin user.
# @param manage_webserver If enabled (default), this module will also manages and installs apache
# @param manage_php If enabled (default), this module also manages and installs php
# @param lang The language of the dokuwiki
# @param license The default license used for all the content placed on the dokuwiki
# @param useacl If set to 1 the ACL module is enable and the dokuwiki will use the acl.auth.php config file
# @param default_acl Specifiy the default acl. Open means: anyone can edit, Public means: anyone can view; users can edit, Closed means: only users can view and edit
# @param replace_acl If set, this module will replace contents of the ACL, possibly revering changes done in the webinterface. Dokuwiki does not recommend this.
# @param superuser This variable determines which user or group defines the super admins
# @param disableactions This variable can be used to disable specific actions: like registering. See https://www.dokuwiki.org/config:disableactions for more information
class dokuwiki (
  String $wiki_title,
  String $admin_user = $dokuwiki::params::admin_user,
  String $admin_passwordhash = $dokuwiki::params::admin_password,
  String $admin_real_name = $dokuwiki::params::admin_real_name,
  String $admin_email = $dokuwiki::params::admin_email,
  Array $admin_groups = $dokuwiki::params::admin_groups,
  Boolean $manage_webserver = $dokuwiki::params::manage_webserver,
  Boolean $manage_php = $dokuwiki::params::manage_php,
  String $lang = $dokuwiki::params::lang,
  String $license = $dokuwiki::params::license,
  Enum[0, 1] $useacl = $dokuwiki::params::useacl,
  Enum['public', 'open', 'closed'] $default_acl = $dokuwiki::params::default_acl,
  Boolean $replace_acl = $dokuwiki::params::replace_acl,
  String $superuser = $dokuwiki::params::superuser,
  String $disableactions = $dokuwiki::params::disableactions,
) inherits dokuwiki::params {
  class {'dokuwiki::install':}
  -> class {'dokuwiki::config':}
  -> class {'dokuwiki::service':}
}

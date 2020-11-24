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
# @param admin_passwordhash The password hash of the admin user.
#   To generate the hash use the mkpasswd, which is part of the whois package.
#   Generate the password using the following command: ```mkpasswd -m sha-512 -s <<< YourPass```
# @param admin_real_name The real name of the admin user
# @param admin_email The e-mail adres of the admin user
# @param admin_groups An array of group for the admin user.
# @param manage_webserver If enabled (default), this module will also manages and installs apache
# @param manage_php If enabled (default), this module also manages and installs php
# @param enable_ssl If enabled, this module will enable ssl and also a redirect to port 443 from port 80
# @param servername Default set to the fqdn fact is used for the redirect of port 80 to port 443.
#   Make sure this name is resolve able by the clients accessing the server.
# @param ssl_cert Defaults to the selfsigned snakeoil certificate, but can be used to change
#   the certificate used by the apache instance
# @param ssl_key Defaults to the selfsigned snakeoil private key, but can be used to change the
#   privatekey used by the apache instance
# @param ssl_chain Defaults to undef, but can be used to specify the cachain that apache will sent.
# @param lang The language of the dokuwiki
# @param license The default license used for all the content placed on the dokuwiki
# @param useacl If set to 1 the ACL module is enable and the dokuwiki will use the acl.auth.php config file
# @param default_acl Specifiy the default acl.
#   Open means: anyone can edit, Public means: anyone can view; users can edit, Closed means: only users can view and edit
# @param replace_acl If set, this module will replace contents of the ACL, possibly revering changes done in the webinterface.
#   Dokuwiki does not recommend this.
# @param replace_local If set (default unset), this module will replace contents of the local.php file, possibly reverting
#   changes done in the webinterface.
# @param replace_users_auth If set, this module will replace contents in the users.auth.php file, possibly reverting changes
#   done in the webitnerface.
# @param superuser This variable determines which user or group defines the super admins
# @param disableactions This variable can be used to disable specific actions: like registering.
#   See https://www.dokuwiki.org/config:disableactions for more information
# @param userewrite The variable can be used to enable rewrites. Defaults to 0.
class dokuwiki (
  String $wiki_title,
  String $admin_user,
  String $admin_passwordhash,
  String $admin_real_name,
  String $admin_email,
  Array $admin_groups,
  String $ssl_cert,
  String $ssl_key,
  Stdlib::Absolutepath $install_path,
  Stdlib::Absolutepath $tmp_dir,
  String $archive,
  Stdlib::HTTPUrl $download_link,
  Optional[String] $ssl_chain,
  String $servername,
  String $lang,
  String $license,
  Integer $useacl,
  Enum['public', 'open', 'closed'] $default_acl,
  Boolean $replace_acl,
  Boolean $replace_local,
  Boolean $replace_users_auth,
  String $user,
  String $group,
  String $superuser,
  String $disableactions,
  Integer[0, 2] $userewrite,
  Boolean $manage_webserver,
  Boolean $manage_php,
  Boolean $enable_ssl,
  Boolean $manage_archive_requirements,
) {
  class {'dokuwiki::install':}
  -> class {'dokuwiki::config':}
  -> class {'dokuwiki::service':}
}

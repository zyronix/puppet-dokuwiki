# dokuwiki::user
#
# Creates local user in the users.auth.php file
#
# @summary Creates local user in the users.auth.php file
#
# @example
#   dokuwiki::user { 'admin':
#     passwordhash => '$1$4fd0ad31$.cId7p1uxI4a.RcrH81On0',
#     real_name    => 'admin',
#     email        => 'root@localhost',
#     groups       => ['user', 'admin'],
#   }
#
# @param passwordhash The password hash for the user. To generate the hash use the mkpasswd, which is part of the whois package. Generate the password using the following command: 'mkpasswd -m sha-512 -s <<< YourPass'
# @param real_name The real name of the user, used to display the name of the user when pages are edit or created.
# @param email The e-mail address of the user.
# @param groups The groups of the user.
# @param login The username of the user to create, default to the $name parameter.
define dokuwiki::user(
  String $passwordhash = '',
  String $real_name = '',
  String $email = '',
  Array $groups = [],
  String $login = $name,
) {
  concat::fragment { "dokuwiki_user_${login}":
    target  => "${dokuwiki::install_path}/dokuwiki/conf/users.auth.php",
    content => template('dokuwiki/user.erb'),
    order   => '10'
  }
}

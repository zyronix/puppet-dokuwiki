# dokuwiki::acl
#
# Create ACL rules in the acl.auth.php configuration file
#
# @summary Create ACL rules in the acl.auth.php configuration file
#
# @example
#   dokuwiki::acl { 'acl_line': 
#     namespace  => '*',
#     group      => '@ALL',
#     permission => '8',
#   }
#
# @param namespace Specify the name for which this ACL rule applies. Use '*' to apply rule to all namespaces.
# @param group Specify the group for which this ACL rule applies. 
#   Start the group name with the '@' sign and use '*' to apply rule to all groups.
# @param permission Specify the permission for this ACL rule. 
#   Possible permissions are: 1 for read, 2 edit, 4 create, 8 upload. See https://www.dokuwiki.org/acl for more information.
define dokuwiki::acl (
  String $namespace,
  String $group,
  Numeric $permission,
) {
  concat::fragment { "dokuwiki_acl_${name}":
    target  => "${dokuwiki::install_path}/dokuwiki/conf/acl.auth.php",
    content => template('dokuwiki/acl.erb'),
    order   => '10'
  }
}

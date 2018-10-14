# dokuwiki::config
#
# Main configuration of dokuwiki
#
# @summary Main configuration of dokuwiki
#
# @example
#   This class should not be called
class dokuwiki::config {
  $manage_webserver = $dokuwiki::manage_webserver
  $enable_ssl = $dokuwiki::enable_ssl

  file {"${dokuwiki::install_path}/dokuwiki/conf/local.php":
    ensure  => file,
    content => template('dokuwiki/local.php.erb'),
    mode    => '0644',
    owner   => $dokuwiki::user,
    group   => $dokuwiki::group,
  }

  file {"${dokuwiki::install_path}/dokuwiki/install.php":
    ensure => absent,
  }

  if $dokuwiki::useacl == 1 {
    dokuwiki::user {'adminuser':
      login        => $dokuwiki::admin_user,
      passwordhash => $dokuwiki::admin_passwordhash,
      real_name    => $dokuwiki::admin_real_name,
      email        => $dokuwiki::admin_email,
      groups       => $dokuwiki::admin_groups,
    }
    if $dokuwiki::default_acl == 'open' {
      dokuwiki::acl {'all':
        namespace  => '*',
        group      => '@ALL',
        permission => 8,
      }
    } elsif $dokuwiki::default_acl == 'public' {
      dokuwiki::acl {'all':
        namespace  => '*',
        group      => '@ALL',
        permission => 1,
      }
      dokuwiki::acl {'users':
        namespace  => '*',
        group      => '@user',
        permission => 8,
      }
    } else {
      # If any other case (aka: closed)
      dokuwiki::acl {'all':
        namespace  => '*',
        group      => '@ALL',
        permission => 0,
      }
      dokuwiki::acl {'users':
        namespace  => '*',
        group      => '@user',
        permission => 8,
      }
    }
  }
  concat { "${dokuwiki::install_path}/dokuwiki/conf/users.auth.php":
    ensure => present,
    owner  => $dokuwiki::user,
    group  => $dokuwiki::group,
  }

  concat::fragment { 'dokuwiki_user_header':
    target  => "${dokuwiki::install_path}/dokuwiki/conf/users.auth.php",
    content => template('dokuwiki/user_header.erb'),
    order   => '01'
  }

  concat {"${dokuwiki::install_path}/dokuwiki/conf/acl.auth.php":
    ensure  => present,
    replace => $dokuwiki::replace_acl,
    owner   => $dokuwiki::user,
    group   => $dokuwiki::group,
  }

  concat::fragment { 'dokuwiki_acl_header':
    target  => "${dokuwiki::install_path}/dokuwiki/conf/acl.auth.php",
    content => template('dokuwiki/acl_header.erb'),
    order   => '01'
  }

  if $manage_webserver {
    if enable_ssl {
      apache::vhost { 'dokuwiki-ssl':
        port           => '443',
        manage_docroot => false,
        override       => 'All',
        docroot        => "${dokuwiki::install_path}/dokuwiki",
        ssl            => true,
        ssl_cert       => $dokuwiki::ssl_cert,
        ssl_key        => $dokuwiki::ssl_key,
      }
      apache::vhost { 'dokuwiki':
        port            => '80',
        manage_docroot  => false,
        redirect_status => 'permanent',
        docroot         => "${dokuwiki::install_path}/dokuwiki",
        redirect_dest   => "https://${dokuwiki::servername}/",
      }
    } else {
      apache::vhost { 'dokuwiki':
        port           => '80',
        manage_docroot => false,
        override       => 'All',
        docroot        => "${dokuwiki::install_path}/dokuwiki",
      }
    }
  }
}

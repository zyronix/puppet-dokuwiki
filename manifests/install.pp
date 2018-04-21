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
      mpm_module    => 'prefork',
      default_vhost => false,
    }
  }

  if $manage_php {
    class { '::php::globals':
      php_version => $dokuwiki::php_version,
      config_root => "/etc/php/${dokuwiki::php_version}",
    }
  -> class {'php':
    }
  }

  if $manage_php and $manage_webserver {
    class {'apache::mod::php':
    }
  }

  # Install requirements for archive module
  package { 'curl':
    ensure => present,
  }

  package { 'tar':
    ensure => present,
  }

  Archive {
    require  => Package['curl', 'tar'],
  }

  file {$dokuwiki::install_path:
    ensure => directory,
    owner  => $dokuwiki::user,
    group  => $dokuwiki::group,
  }

  # Install Dokuwiki
  archive {'dokuwiki_tar':
    path         => "${dokuwiki::tmp_dir}/${dokuwiki::archive}",
    source       => $dokuwiki::download_link,
    extract      => true,
    extract_path => $dokuwiki::install_path,
    creates      => "${dokuwiki::install_path}/dokuwiki",
    cleanup      => false,
    user         => $dokuwiki::user,
    group        => $dokuwiki::group,
    require      => [Class['apache'], File[$dokuwiki::install_path]],
  }
  -> file {'/usr/local/bin/symlink':
    ensure  => file,
    content => template('dokuwiki/symlink.sh.rb'),
    mode    => '0755'
  }
  -> exec {'/usr/local/bin/symlink':
    creates     => "${dokuwiki::install_path}/dokuwiki",
    subscribe   => Archive['dokuwiki_tar'],
    refreshonly => true,
  }
  -> apache::vhost { 'dokuwiki':
    port           => '80',
    manage_docroot => false,
    override       => 'All',
    docroot        => "${dokuwiki::install_path}/dokuwiki",
  }


}

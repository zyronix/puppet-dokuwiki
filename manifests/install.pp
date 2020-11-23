# dokuwiki::install
#
# Main installation of dokuwiki
#
# @summary Main installation of dokuwiki
#
# @example
#   This class should not be called
class dokuwiki::install {
  $manage_webserver = $dokuwiki::manage_webserver
  $manage_php = $dokuwiki::manage_php

  if $manage_webserver {
    class {'apache':
      mpm_module    => 'prefork',
      default_vhost => false,
      default_mods  => false,
    }
  }

  if $manage_php and $manage_webserver {
    if $::facts['os']['family'] == 'Debian' {
      exec {'disable mpm_event':
        command => 'rm /etc/apache2/mods-enabled/mpm_event.load',
        path    => ['/usr/sbin', '/bin'],
        onlyif  => 'a2query -m mpm_event',
        require => Package['httpd'],
        before  => Class['apache::mod::php']
      }
    }
    class {'apache::mod::php':
    }

    package {'php7.0-xml':
      notify => Service['httpd'],
    }
    if $dokuwiki::userewrite == 1 {
      class {'apache::mod::rewrite':
      }
    }
  }

  if $dokuwiki::manage_archive_requirements {
    # Install requirements for archive module
    ensure_packages(['curl', 'tar'])
    Archive {
      require  => Package['curl', 'tar'],
    }
  }

  file {$dokuwiki::install_path:
    ensure => directory,
    owner  => $dokuwiki::user,
    group  => $dokuwiki::group,
  }

  $dokuwiki_symlink_script = '/usr/local/bin/dokuwiki_web_symlink'
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
    require      => File[$dokuwiki::install_path],
  }
  -> file {$dokuwiki_symlink_script:
    ensure  => file,
    content => template('dokuwiki/symlink.sh.erb'),
    mode    => '0755'
  }
  ~> exec {$dokuwiki_symlink_script:
    creates     => "${dokuwiki::install_path}/dokuwiki",
    subscribe   => Archive['dokuwiki_tar'],
    refreshonly => true,
  }
}

# Quick and dirty way of installing extensions
define dokuwiki::extension(
  String $extension = $title,
  Enum['present','absent', 'disabled', 'enabled'] $ensure = 'present',
) {
  $installed = $extension in $facts['dokuwiki_plugins']

  if $installed and $ensure == 'absent' {
    exec{"Remove dokuwiki plugin $extension":
      command => "php ${dokuwiki::install_path}/dokuwiki/bin/plugin.php extension uninstall ${extension}",
      path    => ['/bin', '/usr/bin'],
    }
  }
  elsif (! $installed) and $ensure == 'present' {
    exec{"Install dokuwiki plugin $extension":
      command => "php ${dokuwiki::install_path}/dokuwiki/bin/plugin.php extension install ${extension}",
      path    => ['/bin', '/usr/bin'],
    }
  }
}

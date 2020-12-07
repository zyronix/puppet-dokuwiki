# Simple helper class to support fact resolution (stuff in lib/facter requires some extra info
class dokuwiki::facts(
  Stdlib::Absolutepath $base_path,
) {
  file{$base_path:
    ensure => directory,
  }
  file{"${base_path}/install_path":
    ensure  => file,
    content => "${dokuwiki::install_path}/dokuwiki",
  }
}

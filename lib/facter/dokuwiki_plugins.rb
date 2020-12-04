Facter.add(:dokuwiki_plugins) do
  confine :kernel => 'Linux'
  setcode do
    Facter::Util::Resolution.exec('php /var/www/dokuwiki/bin/plugin.php extension list -f i').split("\n").each { |plugin| plugin.split(' ')[0] }
  end
end

Facter.add(:dokuwiki_plugins) do
  confine :kernel => 'Linux'
  setcode do
    install_path = Facter.value(:dokuwiki_install_path) || '/var/www/dokuwiki'
    installed_plugins = []
    all_plugins = Facter::Util::Resolution.exec("php #{install_path}/bin/plugin.php extension list -f i").split("\n")
    all_plugins.each_line do |p|
      %r{\A(?<plugin>\S+) +(?<state>[ibgdu]+) +(?<date_updated>\d{4}-\d{2}-\d{2}) +(?<description>\S+)\z} =~ p
      if plugin and state == 'i' then
        installed_plugins.push(plugin)
      end
    end
    installed_plugins
  end
end

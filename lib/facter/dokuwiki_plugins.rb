Facter.add(:dokuwiki_install_path) do
  confine :kernel => 'Linux'
  setcode do
    f = '/var/lib/dokuwiki/install_path'
    if File.exist? f
      File.read f
    end
  end
end
Facter.add(:dokuwiki_plugins) do
  confine :kernel => 'Linux'
  setcode do
    install_path = Facter.value(:dokuwiki_install_path) || nil
    if install_path then
      installed_plugins = []
      all_plugins = Facter::Util::Resolution.exec("php #{install_path}/bin/plugin.php extension list -f i").split("\n")
      all_plugins.each do |p|
        %r{\A(?<plugin>\S+) +(?<state>[ibgdu]+) +(?<date_updated>\d{4}-\d{2}-\d{2}) +(?<description>[\S ]+)\z} =~ p
        if plugin and state == 'i' then
          installed_plugins.push(plugin)
        end
      end
      installed_plugins
    end
  end
end

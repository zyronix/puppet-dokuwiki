require 'spec_helper'

describe 'dokuwiki' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) { { wiki_title: 'my wiki' } }

      it {
        is_expected.to compile
        case facts[:operatingsystem]
        when 'Debian'
          is_expected.to contain_file('dokuwiki-local.php').with(
            'path' => '/var/www/dokuwiki/conf/local.php',
          )
        end
      }
    end
    context "on #{os} with ssl enabled" do
      let(:facts) { os_facts }
      let(:params) do
        {
          wiki_title: 'my wiki',
          enable_ssl: true,
          ssl_cert: '/etc/ssl/test.pem',
          ssl_key: '/etc/ssl/test.key',
        }
      end

      it {
        is_expected.to contain_apache__vhost('dokuwiki-ssl').with(
          'ssl_cert' => '/etc/ssl/test.pem',
          'ssl_key' => '/etc/ssl/test.key',
        )
      }
    end
    context "on #{os} with replace_local enabled and replace_users_auth enabled" do
      let(:facts) { os_facts }
      let(:params) do
        {
          wiki_title: 'my wiki',
          replace_local: true,
          replace_users_auth: true,
        }
      end

      it {
        is_expected.to contain_file('dokuwiki-local.php').with(
          'replace' => true,
        )
        is_expected.to contain_concat('dokuwiki-users.auth.php').with(
          'replace' => true,
        )
      }
    end
  end
end

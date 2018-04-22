require 'spec_helper'

describe 'dokuwiki::user' do
  let(:pre_condition) do
    "class { 'dokuwiki': wiki_title => 'my_wiki' }"
  end
  let(:title) { 'admin' }
  let(:params) do
    {
      passwordhash: '$1$4fd0ad31$.cId7p1uxI4a.RcrH81On0',
      real_name: 'admin',
      email: 'root@localhost',
      groups: %w[user admin],
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end
end

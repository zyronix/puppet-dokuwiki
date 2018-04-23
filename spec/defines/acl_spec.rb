require 'spec_helper'

describe 'dokuwiki::acl' do
  let(:pre_condition) do
    "class { 'dokuwiki': wiki_title => 'my_wiki' }"
  end
  let(:title) { 'acl' }
  let(:params) do
    {
      namespace: '*',
      group: '@ALL',
      permission: 8,
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end
end

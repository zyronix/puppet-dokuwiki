require 'spec_helper'

describe 'dokuwiki' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) { { wiki_title: 'my wiki' } }

      it { is_expected.to compile }
    end
  end
end

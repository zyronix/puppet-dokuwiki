require 'spec_helper_acceptance'

describe 'dokuwiki class' do
  describe 'config' do
    let(:pp) do
      <<-MANIFEST
        class { 'dokuwiki': }
      MANIFEST
    end

    it_behaves_like 'a idempotent resource'
  end
end

require 'spec_helper'

describe 'mysql2_chef_gem_test::default' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node|
      node.default['mysql2_chef_gem']['provider'] = 'mysql'
    end.converge('mysql2_chef_gem_test::default')
  end

  context 'when using default parameters' do
    it 'creates mysql2_chef_gem[default]' do
      expect(chef_run).to install_mysql2_chef_gem('default')
    end
  end
end

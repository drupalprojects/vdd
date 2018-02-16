require 'spec_helper'

describe 'mysql2_chef_gem_test::default' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set['mysql2_chef_gem']['resource_name'] = 'default'
    end.converge('mysql2_chef_gem_test::default')
  end

  context 'when using default parameters' do
    it 'creates mysql2_chef_gem[default]' do
      expect(chef_run).to install_mysql2_chef_gem('default')
    end
  end
end

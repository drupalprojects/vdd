require 'spec_helper'

describe 'xml::default' do
  let(:chef_run) { ChefSpec::ChefRunner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe) }

  it 'installs the XML package' do
    expect(chef_run).to install_package('libxml2-dev')
    expect(chef_run).to install_package('libxslt-dev')
  end
end

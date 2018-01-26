require 'serverspec'

set :backend, :exec

describe command('/opt/chef/embedded/bin/gem list mysql2 | grep mysql2') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match("mysql2 (0.4.5)\n") }
end

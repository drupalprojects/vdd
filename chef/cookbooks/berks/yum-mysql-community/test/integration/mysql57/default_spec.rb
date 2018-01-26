describe command('yum -y install mysql-community-server') do
  its('exit_status') { should eq 0 }
end

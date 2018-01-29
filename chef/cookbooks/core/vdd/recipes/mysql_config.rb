bash 'mysql_secure_install emulate' do
  code <<-"EOH"
    /usr/bin/mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root'"  -D mysql
  EOH
  action :run
  only_if "/usr/bin/mysql -u root -e 'show databases;'"
end
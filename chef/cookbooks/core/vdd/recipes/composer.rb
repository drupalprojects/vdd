# Install Composer globally.
bash "install-composer" do
  code <<-EOH
  curl -sS https://getcomposer.org/installer | php
  mv composer.phar /usr/local/bin/composer
  EOH
  not_if { ::File.exists?("/usr/local/bin/composer") }
end

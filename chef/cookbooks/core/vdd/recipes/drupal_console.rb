bash 'install_drupal_console' do
	code <<-EOH
		php -r "readfile('https://drupalconsole.com/installer');" > drupal.phar
		if [ $? -eq 0 ] && [ -f "drupal.phar" ]; then
			chmod +x drupal.phar
			mv drupal.phar /usr/local/bin/drupal
		fi
	EOH
	creates '/usr/local/bin/drupal'
end
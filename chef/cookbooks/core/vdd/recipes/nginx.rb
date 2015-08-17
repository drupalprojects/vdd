certificate_path = node["ssl"]["certificate_path"]

template "/etc/nginx/sites-enabled/default.conf" do
  source "nginx/default.conf.erb"
  variables(
    certificate_path: certificate_path,
  )
end

if node["vdd"]["sites"]

  node["vdd"]["sites"].each do |index, site|

      site_type = "drupal7"

      if !site["type"].nil? then
        site_type = site["type"]
      end

      if File.exists?("/var/www/vhosts/#{index}.dev/.vdd/nginx.conf")
        file "/etc/nginx/sites-enabled/#{index}.dev.conf" do
          owner 'www-data'
          group 'www-data'
          mode 0755
          content ::File.open("/var/www/vhosts/#{index}.dev/.vdd/nginx.conf").read
          action :create
        end
      else
        template "/etc/nginx/sites-enabled/#{index}.dev.conf" do
          source "nginx/nginx-#{site_type}-site.conf.erb"
          variables(
            shortcode: index,
            certificate_path: certificate_path,
            docroot: site['vhost']['document_root'],
            alias: defined?(site["vhost"]["alias"]) ? site["vhost"]["alias"].join(" ") : ""
          )
        end
    end

  end

end

template "/etc/init/nginx-start.conf" do
  source "nginx/upstart.conf"
end

service "nginx" do
  action :restart
end
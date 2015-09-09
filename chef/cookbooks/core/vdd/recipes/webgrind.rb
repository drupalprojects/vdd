git "/var/www/html/webgrind" do
  repository "https://github.com/jokkedk/webgrind.git"
  reference "master"
  action :sync
end

link "/usr/local/bin/dot" do
  to "/usr/bin/dot"
end

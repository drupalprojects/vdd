# Install grunt
nodejs_npm "grunt-cli"

# Install sass
gem_package "sass" do
  action :install
end

# Install compass
gem_package "compass" do
  action :install
end

# Install grunt contrib watch
nodejs_npm "grunt-contrib-watch" do
  options ['-save-dev']
end

# Install grunt contrib compass
nodejs_npm "grunt-contrib-compass" do
  options ['-save-dev']
end

# Install grunt contrib sass
nodejs_npm "grunt-contrib-sass" do
  options ['-save-dev']
end

# Include bootstrap sass globally
nodejs_npm "bootstrap-sass"

# Have a grunt examples directory
directory "/usr/share/examples/grunt" do
  mode  00777
  action :create
  recursive true
end

# Include the example scss style override file
template "/usr/share/examples/grunt/style.scss.example" do
  source "grunt/style.scss.example"
end

# Include the example grunt package json file
template "/usr/share/examples/grunt/package.json.example" do
  source "grunt/package.json.example"
end

# Include the example Gruntfile.js
template "/usr/share/examples/grunt/Gruntfile.js.example" do
  source "grunt/Gruntfile.js.example"
end
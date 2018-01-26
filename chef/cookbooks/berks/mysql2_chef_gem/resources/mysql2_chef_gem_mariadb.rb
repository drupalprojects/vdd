property :mysql2_chef_gem_name, String, name_property: true, required: true
property :gem_version, String, default: '0.4.9'
property :package_version, String

provides :mysql2_chef_gem_mariadb

action :install do
  recipe_eval do
    run_context.include_recipe 'build-essential::default'
  end

  # As a recipe: must rely on global node attributes
  recipe_eval do
    run_context.include_recipe 'mariadb::client'
  end

  gem_package 'mysql2' do
    gem_binary RbConfig::CONFIG['bindir'] + '/gem'
    version new_resource.gem_version
    action :install
  end
end

action :remove do
  gem_package 'mysql2' do
    gem_binary RbConfig::CONFIG['bindir'] + '/gem'
    action :remove
  end
end

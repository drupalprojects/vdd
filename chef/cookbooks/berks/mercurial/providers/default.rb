use_inline_resources

# Support whyrun
def whyrun_supported?
  true
end

action :sync do
  if current_resource.synced
    Chef::Log.info "#{ new_resource } already synced - nothing to do."
  elsif current_resource.exists
    converge_by("Sync #{ @new_resource }") do
      sync
    end
  else
    converge_by("Clone #{ @new_resource }") do
      clone
    end
  end
end

action :clone do
  if current_resource.exists
    Chef::Log.info "#{ new_resource } already exists - nothing to do."
  else
    converge_by("Clone #{ @new_resource }") do
      clone
    end
  end
end

def clone
  execute "clone repository #{new_resource.path}" do
    command "hg clone #{hg_connection_command} #{new_resource.repository} #{new_resource.path}"
    user new_resource.owner
    group new_resource.group
  end
  update
end

def sync
  execute "pull #{new_resource.path}" do
    command "hg unbundle -u #{bundle_file}"
    user new_resource.owner
    group new_resource.group
    cwd new_resource.path
    only_if { ::File.exists?(bundle_file) || repo_incoming? }
    notifies :delete, "file[#{bundle_file}]"
  end
  update

  file bundle_file do
    action :nothing
  end
end

def update
  execute "hg update for #{new_resource.path}" do
    command "hg update --rev #{new_resource.reference}"
    user new_resource.owner
    group new_resource.group
    cwd new_resource.path
  end
end

def load_current_resource
  init
  @current_resource = Chef::Resource::Mercurial.new(@new_resource.name)
  @current_resource.name(@new_resource.name)
  @current_resource.path(@new_resource.path)
  if repo_exists?
    @current_resource.exists = true
    @current_resource.synced = !repo_incoming?
  end
end

def repo_exists?
  command = Mixlib::ShellOut.new("hg identify #{new_resource.path}").run_command
  Chef::Log.debug "'hg identify #{new_resource.path}' return #{command.stdout}"
  return command.exitstatus == 0
end

def repo_incoming?
  cmd = "hg incoming --rev #{new_resource.reference} #{hg_connection_command} --bundle #{bundle_file} #{new_resource.repository}"
  command = Mixlib::ShellOut.new(cmd, :cwd => new_resource.path, :user => new_resource.owner, :group => new_resource.group).run_command
  Chef::Log.debug "#{cmd} return #{command.stdout}"
  return command.exitstatus == 0
end

def init
  directory tmp_directory do
    owner new_resource.owner
    group new_resource.group
    recursive true
    mode 0755
  end
end

def tmp_directory
  ::File.join(Chef::Config[:file_cache_path], "mercurial", sanitize_filename(new_resource.path))
end

def bundle_file
  ::File.join(tmp_directory, "bundle")
end

def sanitize_filename(filename)
  filename.gsub(/[^0-9A-z.\-]/, '_')
end

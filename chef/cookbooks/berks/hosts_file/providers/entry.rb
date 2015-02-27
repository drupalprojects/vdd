def load_current_resource
  new_resource.ip_address new_resource.name unless new_resource.ip_address
  if(new_resource.comment && !new_resource.comment.start_with?('#'))
    new_resource.comment "# #{new_resource.comment}"
  end
  node.run_state[:hosts_file] ||= Mash.new(:maps => Mash.new)
end

action :create do
  ruby_block "hosts_file create[#{new_resource.name}]" do
    block do
      node.run_state[:hosts_file][:maps][new_resource.ip_address] = %w(hostname aliases comment).map{|item|
        Array(new_resource.send(item))
      }.inject(&:+).join(' ')
      new_resource.updated_by_last_action(true)
    end
    only_if do
      node.run_state[:hosts_file][:maps][new_resource.ip_address].nil? ||
      node.run_state[:hosts_file][:maps][new_resource.ip_address] != %w(hostname aliases comment).map{|item|
        Array(new_resource.send(item))
      }.inject(&:+).join(' ')
    end
  end
end

action :delete do
  # implicit deletions
end

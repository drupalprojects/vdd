# Managed Hosts File

Manage your hosts file with chef.

### Base configurables:

* `default[:hosts_file][:path] = '/etc/hosts'`
* `default[:hosts_file][:define_self] = 'ip_address' # or 'loopback' or 'localhost_only'`

### Via Attributes

```ruby
override_attributes(
  :hosts_file => {
    :custom_entries => {
      '192.168.0.100' => 'www.google.com',
      '192.168.0.101' => %w(www.yahoo.com www.altavista.com)
    }
  }
)
```

### Via LWRP

```ruby
hosts_file_entry '192.168.0.100' do
  hostname 'www.google.com'
  aliases %w(google.com gmail.com www.gmail.com)
  comment "Override some google lookups"
end
```

and ensure you add the default recipe to the run list:

```ruby
run_list(["recipe[hosts_file]"])
```

### Repo:

* https://github.com/hw-cookbooks/hosts_file


default_action :create

actions :create, :delete

attribute :ip_address, :kind_of => String
attribute :hostname, :kind_of => String, :required => true
attribute :aliases, :kind_of => [Array, String]
attribute :comment, :kind_of => String

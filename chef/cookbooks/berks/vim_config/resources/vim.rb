actions :create

default_action :create

attribute :name, :kind_of => String, :required => true, :name_attribute => true
attribute :version, :kind_of => String, :required => true
attribute :force, :equal_to => [true, false], :default => false

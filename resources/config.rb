actions :update
default_action :update

attribute :name, :name_attribute => true, :kind_of => String, :required => false
attribute :auth, :kind_of => [TrueClass,FalseClass], :required => false, :default => false
attribute :service, :kind_of => String, :required => true
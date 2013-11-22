actions :update
default_action :update

attribute :name, :name_attribute => true, :kind_of => String
attribute :auth, :kind_of => [TrueClass, FalseClass], :default => false
attribute :service_name, :kind_of => String

def initialize(*args)
  super
  @action = :update
end
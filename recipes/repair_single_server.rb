#
# Cookbook Name:: mongodb
# Recipe:: repair_single_server
#
# Copyright (C) 2013 Alexander Merkulov
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

bash "repair mongodb after a crash" do
  environment "HOME"=>"/root" 
 
  lock_file = File.join(node[:mongodb][:path],'mongod.lock')
  
  code <<-EOH
    set -e
    rm #{lock_file}
    sudo -u mongodb #{node[:mongodb][:path]}/bin/mongod --dbpath=#{node[:mongodb][:path]} --repair
  EOH
  
  not_if { `ps -A -o command | grep "[m]ongo"`.include? node[:mongodb][:configfile] }
  only_if { ::FileTest.exists?(lock_file) }
  notifies :restart, "service[#{node[:mongodb][:instance_name]}]"
end
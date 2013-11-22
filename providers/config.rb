#
# Cookbook Name:: mongodb
# Provider:: config 
#
# Authors:
#       Alexander Merkulov <sasha@merqlove.ru>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

action :update do
  auth = new_resource.auth
  name = new_resource.name
  service_name = new_resource.service_name

  template node['mongodb']['dbconfig_file'] do
    cookbook node['mongodb']['template_cookbook']
    source node['mongodb']['dbconfig_file_template']
    group node['mongodb']['root_group']
    owner "root"
    mode "0644"
    variables ({
      auth: auth
    })
    action :create
    notifies :restart, "service[#{service_name}]", :delayed
  end

  new_resource.updated_by_last_action(true)
end
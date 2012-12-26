# Author:: yamakatu(yamakatun@hotmail.co.jp)
#
# Copyright 2012 yamakatu
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

package "iptables" do
  action :install
end

case node['platform']
when "rhel", "fedora", "centos"
  rule_file = "/etc/sysconfig/iptables"
else
  raise "not implemented."
end

cookbook_file rule_file do
  source "iptables"
  mode 0600
  owner 'root'
  group 'root'
end

service "iptables" do
  case node['platform']
  when "rhel", "fedora", "centos"
    start_command "/sbin/service iptables start"
  else
    raise "not implemented."
  end
  action [:enable, :start]
end

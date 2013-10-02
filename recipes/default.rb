
package "iptables"
package "iptables-persistent"

# use custom init script for providing ip6tables support to Debian Squeeze
cookbook_file "/etc/init.d/iptables-persistent" do
  source "iptables-persistent.init"
  mode 00755
end

directory "/etc/iptables" do
  action :create
end

# needs trailing newline at end of file!
cookbook_file "/etc/iptables/rules" do
  source node['iptables-persistent']['rules_name']
  owner "root"
  group "root"
  mode 00600
  cookbook node['iptables-persistent']['file_cookbook'] if node['iptables-persistent']['file_cookbook']
  notifies :restart, "service[iptables-persistent]"
end

# needs trailing newline at end of file!
cookbook_file "/etc/iptables/rules.v6" do
  source node['iptables-persistent']['rules.v6_name']
  owner "root"
  group "root"
  mode 00600
  cookbook node['iptables-persistent']['file_cookbook'] if node['iptables-persistent']['file_cookbook']
  notifies :restart, "service[iptables-persistent]"
end

service "iptables-persistent" do
  action [:enable, :start]
end

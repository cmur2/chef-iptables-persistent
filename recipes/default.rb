
package "iptables" do
  action :upgrade
end

package "iptables-persistent" do
  action :upgrade
end

# use custom init script for providing ip6tables support to Debian Squeeze
cookbook_file "/etc/init.d/iptables-persistent" do
  source "iptables-persistent.init"
  mode 0755
end

directory "/etc/iptables" do
  action :create
end

# needs trailing newline at end of file!
cookbook_file "/etc/iptables/rules" do
  content "rules"
  owner "root"
  group "root"
  mode 0600
  notifies :restart, "service[iptables-persistent]"
end

# needs trailing newline at end of file!
cookbook_file "/etc/iptables/rules.v6" do
  content "rules.v6"
  owner "root"
  group "root"
  mode 0600
  notifies :restart, "service[iptables-persistent]"
end

service "iptables-persistent" do
  action [:enable, :start]
end

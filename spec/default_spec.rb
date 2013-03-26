require 'chefspec'

describe 'iptables-persistent::default' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'iptables-persistent::default' }
  
  it "installs iptables and iptables-persistent" do
    expect(chef_run).to install_package 'iptables'
    expect(chef_run).to install_package 'iptables-persistent'
  end
  
  it "creates an init script" do
    expect(chef_run).to create_cookbook_file "/etc/init.d/iptables-persistent"
  end
  
  it "creates ipv4 rules" do
    expect(chef_run).to create_cookbook_file "/etc/iptables/rules"
  end
  
  it "creates ipv6 rules" do
    expect(chef_run).to create_cookbook_file "/etc/iptables/rules.v6"
  end
  
  it "enables and starts iptables-persistent" do
    expect(chef_run).to start_service "iptables-persistent"
    expect(chef_run).to set_service_to_start_on_boot "iptables-persistent"
  end
end


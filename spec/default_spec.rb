require 'chefspec'

describe 'iptables-persistent::default' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'iptables-persistent::default' }
  
  it "installs iptables and iptables-persistent" do
    expect(chef_run).to install_package 'iptables'
    expect(chef_run).to install_package 'iptables-persistent'
  end
end


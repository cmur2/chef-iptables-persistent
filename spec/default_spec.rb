require 'chefspec'
begin require 'chefspec/deprecations'; rescue LoadError; end

describe 'iptables-persistent::default' do
  let(:chef_runner) do
    cb_path = [Pathname.new(File.join(File.dirname(__FILE__), '..', '..')).cleanpath.to_s, 'spec/support/cookbooks', 'spec/support/my-cookbooks']
    ChefSpec::ChefRunner.new(:cookbook_path => cb_path)
  end
  
  let(:chef_run) do
    chef_runner.converge 'iptables-persistent::default'
  end
  
  it 'installs iptables and iptables-persistent' do
    expect(chef_run).to install_package 'iptables'
    expect(chef_run).to install_package 'iptables-persistent'
  end
  
  it 'creates an init script' do
    expect(chef_run).to create_file_with_content "/etc/init.d/iptables-persistent", "### BEGIN INIT INFO"
  end
  
  context 'with file_cookbook' do
    it 'creates ipv4 rules' do
      chef_runner.node.set['iptables-persistent']['file_cookbook'] = 'iptables-persistent-files'
      chef_run = chef_runner.converge 'iptables-persistent::default'
      expect(chef_run).to create_file_with_content "/etc/iptables/rules", "# Generated by iptables-save - overwritten file from file_cookbook"
    end

    it 'creates ipv4 rules from different rules file name' do
      chef_runner.node.set['iptables-persistent']['file_cookbook'] = 'iptables-persistent-files'
      chef_runner.node.set['iptables-persistent']['rules_name'] = 'rules2'
      chef_run = chef_runner.converge 'iptables-persistent::default'
      expect(chef_run).to create_file_with_content "/etc/iptables/rules", "# Generated by iptables-save - overwritten file from file_cookbook"
    end
  
    it 'creates ipv6 rules' do
      chef_runner.node.set['iptables-persistent']['file_cookbook'] = 'iptables-persistent-files'
      chef_run = chef_runner.converge 'iptables-persistent::default'
      expect(chef_run).to create_file_with_content "/etc/iptables/rules.v6", "# Generated by ip6tables-save - overwritten file from file_cookbook"
    end

    it 'creates ipv6 rules from different rules file name' do
      chef_runner.node.set['iptables-persistent']['file_cookbook'] = 'iptables-persistent-files'
      chef_runner.node.set['iptables-persistent']['rules.v6_name'] = 'rules2.v6'
      chef_run = chef_runner.converge 'iptables-persistent::default'
      expect(chef_run).to create_file_with_content "/etc/iptables/rules.v6", "# Generated by ip6tables-save - overwritten file from file_cookbook"
    end
  end
  
  context 'without file_cookbook' do
    it 'creates ipv4 rules' do
      expect(chef_run).to create_file_with_content "/etc/iptables/rules", "# Generated by iptables-save - example file"
    end
  
    it 'creates ipv6 rules' do
      expect(chef_run).to create_file_with_content "/etc/iptables/rules.v6", "# Generated by ip6tables-save - example file"
    end
  end
  
  it 'enables and starts iptables-persistent' do
    expect(chef_run).to start_service "iptables-persistent"
    expect(chef_run).to set_service_to_start_on_boot "iptables-persistent"
  end
end


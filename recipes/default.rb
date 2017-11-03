# Cookbook:: TrendMicro
# Recipe:: default
# Copyright:: 2017, The Authors, All Rights Reserved.


execute 'update' do
 command 'sudo yum update -y'
end
execute 'install wget' do
 command 'yum -y install wget'
end
execute 'pip-install' do
 command "curl 'https://bootstrap.pypa.io/get-pip.py' -o 'get-pip.py'"
end
execute 'python' do
 command 'python get-pip.py'
end
execute 'aws-cli install' do
 command 'pip install awscli'
end

template "/tmp/properties" do 
  source "source.erb" 
  owner "root" 
  group "root" 
  mode "0644" 
end

execute 'private ip' do
 command 'echo "AddressAndPortsScreen.ManagerAddress=$(curl http://169.254.169.254/latest/meta-data/local-ipv4/)" >> /tmp/properties'
end

template "/tmp/aws.sh" do 
  source "manager.erb" 
  owner "root" 
  group "root" 
  mode "0644" 
end

execute 'sh /tmp/aws.sh' do
 command 'sh /tmp/aws.sh'
end

execute 'something' do
 command 'sudo sh /tmp/trendmicro-manager.sh -q -console -varfile /tmp/properties'
end

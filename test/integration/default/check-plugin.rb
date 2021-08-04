describe file('/home/vagrant/.terraform.d/plugins/localproviders/mavidser/linux/1.0.2/linux_amd64/terraform-provider-linux') do
  it {should exist}
  its('md5sum') { should eq 'f46802e787ae030a81a5db01d9ae254f' }
  its('size') { should eq 24120848 }
  its('type') { should eq :file }
  its('owner') { should eq 'vagrant' }
  its('group') { should eq 'vagrant' }
end

describe command('terraform init --upgrade=true && terraform apply --auto-approve=true') do
  its('stdout') {should match /testgroup-id = "100[0-9]"/ }
  its('stdout') {should match /testuser1-id = "100[0-9]"/ }
  its('stdout') {should match /testuser2-id = "100[0-9]"/ }
end

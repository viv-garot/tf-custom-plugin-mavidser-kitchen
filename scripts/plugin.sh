#!/usr/bin/env bash

sudo mkdir -p $GOPATH/src/github.com/terraform-providers
cd $GOPATH/src/github.com/terraform-providers
sudo git clone https://github.com/mavidser/terraform-provider-linux
cd $GOPATH/src/github.com/terraform-providers/terraform-provider-linux
sudo make build
mkdir -p ~/.terraform.d/plugins/localproviders/mavidser/linux/1.0.2/linux_amd64
cp $GOPATH/bin/terraform-provider-linux ~/.terraform.d/plugins/localproviders/mavidser/linux/1.0.2/linux_amd64
cd ~

# ssh key required to ssh to localhost
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod og-wx ~/.ssh/authorized_keys

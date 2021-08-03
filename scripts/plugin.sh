#!/usr/bin/env bash

sudo go get github.com/ivoronin/terraform-provider-macaddress
sudo make build
mkdir -p ~/.terraform.d/plugins/localproviders/ivoronin/macaddress/0.2.2/linux_amd64
cp $GOPATH/bin/terraform-provider-macaddress ~/.terraform.d/plugins/localproviders/ivoronin/macaddress/0.2.2/linux_amd64


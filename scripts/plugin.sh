#!/usr/bin/env bash

# Inspired from Anton Akulov repo https://github.com/antonakv/tf-ob-custom-plugin

sudo go get github.com/petems/terraform-provider-extip
sudo make build
mkdir -p ~/.terraform.d/plugins/localproviders/petems/extip/0.1.2/linux_amd64
cp $GOPATH/bin/terraform-provider-extip ~/.terraform.d/plugins/localproviders/petems/extip/0.1.2/linux_amd64


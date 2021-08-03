#!/usr/bin/env bash

git clone https://github.com/hashicorp/terraform.git
cd terraform
sudo go install
sudo mv /root/go/bin/terraform /usr/local/bin/

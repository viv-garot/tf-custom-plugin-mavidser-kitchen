#!/usr/bin/env bash

cat >> /vagrant/main.tf << EOF

terraform {
  required_providers {
    extip = {
      source = "localproviders/petems/extip"
    }
  }
}

data "extip" "external_ip_from_aws" {
  resolver = "https://checkip.amazonaws.com/"
}

output "external_ip_from_aws" {
  value = data.extip.external_ip_from_aws.ipaddress
}
EOF

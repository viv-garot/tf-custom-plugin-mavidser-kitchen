#!/usr/bin/env bash

cat >> /vagrant/main.tf << EOF

terraform {
  required_providers {
    macaddress = {
      source = "ivoronin/macaddress"
      version = "0.2.2"
    }
  }
}

resource "macaddress" "example_address" {
}

// Terraform Mikrotik Provider - https://github.com/ddelnano/terraform-provider-mikrotik
resource "mikrotik_dhcp_lease" "example_lease" {
  address    = "10.0.0.10"
  macaddress = upper(macaddress.example_address.address)
  comment    = "Example DHCP Lease"
}

output "macaddress" {
  value      = mikrotic_dhcp_lease.example_lease
}
EOF

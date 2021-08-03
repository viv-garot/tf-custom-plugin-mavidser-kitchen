#!/usr/bin/env bash

cat >> /vagrant/main.tf << EOF

terraform {
  required_providers {
    linux = {
      source  = "localproviders/mavidser/linux"
      version = "1.0.2"
    }
  }
}

provider "linux" {
  host = "localhost"
  user = "vagrant"
}

resource "linux_group" "testgroup" {
  name   = "testgroup"
  system = false
}

resource "linux_user" "testuser1" {
  name   = "testuser1"
  gid    = linux_group.testgroup.gid
  system = false
}

resource "linux_user" "testuser2" {
  name   = "testuser2"
  gid    = linux_group.testgroup.gid
  system = false
}

output "testgroup-id" {
  value = linux_group.testgroup.id
}

output "testuser1-id" {
  value = linux_user.testuser1.id
}

output "testuser2-id" {
  value = linux_user.testuser2.id
}
EOF

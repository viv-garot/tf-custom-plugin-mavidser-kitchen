#!/usr/bin/env bash

vagrant up
vagrant package --base tf-plugin-bionic --output tf-plugin-bionic.box
vagrant box add tf-plugin-bionic.box --force --name tf-plugin-bionic
vagrant destroy -f

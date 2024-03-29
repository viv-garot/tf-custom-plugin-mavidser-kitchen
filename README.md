# tf-custom-plugin-mavidser-kitchen

## Description
* Learn how to run locally a custom plugin ([terraform-linux-plugin](https://github.com/mavidser/terraform-provider-linux) from mavidser) and test it with test kitchen

## Pre-requirements

* [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) 
* [Vagrant](https://www.vagrantup.com/downloads)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## How to use this repo

- Clone
- Build the testing instance
- Install Ruby and gem dependencies
- Run test kitchen

---

### Clone the repo

```
git clone https://github.com/viv-garot/tf-custom-plugin-mavidser-kitchen
```

### Change directory

```
cd tf-custom-plugin-mavidser-kitchen
```

### Create the Vagrant box with Terraform and Golang provisioned, and the custom plugin compiled.

* Run the add-box.sh scripts. (This will create a virtualbox VM from the Vagrantfile, package it and finally create a suitable re-usable box for test kitchen).
> Note : This operation takes several minutes

```
bash scripts/add-box.sh
```

_sample_:

```
bash scripts/add-box.sh
Bringing machine 'tf-plugin-bionic' up with 'virtualbox' provider...
==> tf-plugin-bionic: Importing base box 'vivien/bionic64'...
==> tf-plugin-bionic: Matching MAC address for NAT networking...
==> tf-plugin-bionic: Checking if box 'vivien/bionic64' version '21.07.06' is up to date...
==> tf-plugin-bionic: Setting the name of the VM: tf-plugin-bionic
==> tf-plugin-bionic: Clearing any previously set network interfaces...
==> tf-plugin-bionic: Preparing network interfaces based on configuration...
    tf-plugin-bionic: Adapter 1: nat
==> tf-plugin-bionic: Forwarding ports...
    tf-plugin-bionic: 22 (guest) => 2222 (host) (adapter 1)
==> tf-plugin-bionic: Booting VM...
==> tf-plugin-bionic: Waiting for machine to boot. This may take a few minutes...
    tf-plugin-bionic: SSH address: 127.0.0.1:2222
    
## ....
==> tf-plugin-bionic: Attempting graceful shutdown of VM...
==> tf-plugin-bionic: Clearing any previously set forwarded ports...
==> tf-plugin-bionic: Exporting VM...
==> tf-plugin-bionic: Compressing package to: /Users/viviengarot/Desktop/VisualCode/skillsmap/TF/tf-custom-plugin-mavidser-kitchen/tf-plugin-bionic.box
==> box: Box file was not detected as metadata. Adding it directly...
==> box: Adding box 'tf-plugin-bionic' (v0) for provider:
    box: Unpacking necessary files from: file:///Users/viviengarot/Desktop/VisualCode/skillsmap/TF/tf-custom-plugin-mavidser-kitchen/tf-plugin-bionic.box
==> box: Successfully added box 'tf-plugin-bionic' (v0) for 'virtualbox'!
==> tf-plugin-bionic: Destroying VM and associated drives...
```


### Ruby installation

Install Ruby 2.6.6

```
rbenv install -l
rbenv install 2.6.6
rbenv local 2.6.6
```

### Install required RubyGems dependencies locally

```
bundle install --path vendor/bundle
```

_sample_:

```
bundle install --path vendor/bundle
Fetching gem metadata from https://rubygems.org/........
Fetching gem metadata from https://rubygems.org/.
Resolving dependencies....
Fetching concurrent-ruby 1.1.9
Installing concurrent-ruby 1.1.9
Fetching i18n 1.8.10
Installing i18n 1.8.10
Fetching minitest 5.14.4
Installing minitest 5.14.4
Fetching tzinfo 2.0.4
Installing tzinfo 2.0.4
Fetching zeitwerk 2.4.2
Installing zeitwerk 2.4.2

## ...

Installing kitchen-vagrant 1.9.0
Bundle complete! 4 Gemfile dependencies, 186 gems now installed.
Bundled gems are installed into `./vendor/bundle`
Post-install message from rubyzip:
RubyZip 3.0 is coming!
**********************

The public API of some Rubyzip classes has been modernized to use named
parameters for optional arguments. Please check your usage of the
following classes:
  * `Zip::File`
  * `Zip::Entry`
  * `Zip::InputStream`
  * `Zip::OutputStream`

Please ensure that your Gemfiles and .gemspecs are suitably restrictive
to avoid an unexpected breakage when 3.0 is released (e.g. ~> 2.3.0).
See https://github.com/rubyzip/rubyzip for details. The Changelog also
lists other enhancements and bugfixes that have been implemented since
version 2.3.0.
```

### Test kitchen

* Bring up the test kitchen instance (platform defined in the kitchen.yml)

```
bundle exec kitchen converge
```

_sample_:

```
⏚ [viviengarot:~/Desktop/ … smap/TF/tf-custom-plugin-mavidser-kitchen] main(+267/-3)* 7m25s ± bundle exec kitchen converge
-----> Starting Test Kitchen (v3.0.0)
-----> Creating <default-tf-plugin-bionic>...
       Bringing machine 'default' up with 'virtualbox' provider...
       ==> default: Importing base box 'tf-plugin-bionic'...
==> default: Matching MAC address for NAT networking...
       ==> default: Setting the name of the VM: kitchen-tf-custom-plugin-mavidser-kitchen-default-tf-plugin-bionic-c3c1845e-55d9-4dde-a277-c0d9ed213152
       ==> default: Clearing any previously set network interfaces...
       ==> default: Preparing network interfaces based on configuration...
           default: Adapter 1: nat
       ==> default: Forwarding ports...
           default: 22 (guest) => 2222 (host) (adapter 1)
       ==> default: Running 'pre-boot' VM customizations...
       ==> default: Booting VM...
       ==> default: Waiting for machine to boot. This may take a few minutes...
           default: SSH address: 127.0.0.1:2222
           default: SSH username: vagrant
           default: SSH auth method: private key
           default:
           default: Vagrant insecure key detected. Vagrant will automatically replace
           default: this with a newly generated keypair for better security.
           default:
           default: Inserting generated public key within guest...
           default: Removing insecure key from the guest if it's present...
           default: Key inserted! Disconnecting and reconnecting using new SSH key...
       ==> default: Machine booted and ready!
       ==> default: Checking for guest additions in VM...
       ==> default: Setting hostname...
       ==> default: Machine not provisioned because `--no-provision` is specified.
       [SSH] Established
       Vagrant instance <default-tf-plugin-bionic> created.
       Finished creating <default-tf-plugin-bionic> (0m56.85s).
-----> Converging <default-tf-plugin-bionic>...
       Preparing files for transfer
       Preparing script
       No provisioner script file specified, skipping
       Transferring files to <default-tf-plugin-bionic>
       Downloading files from <default-tf-plugin-bionic>
       Finished converging <default-tf-plugin-bionic> (0m0.01s).
-----> Test Kitchen is finished. (0m58.14s)
```

* Check its configuration

```
bundle exec kitchen list
```

_sample_:

```
bundle exec kitchen list
Instance                  Driver   Provisioner  Verifier  Transport  Last Action  Last Error
default-tf-plugin-bionic  Vagrant  Shell        Inspec    Ssh        Converged    <None>
```

* We are finally able to run the tests (defined in test/integration/default/check-plugin.rb)

```
bundle exec kitchen verify
```

_sample_:
```
bundle exec kitchen verify
-----> Starting Test Kitchen (v3.0.0)
-----> Setting up <default-tf-plugin-bionic>...
       Finished setting up <default-tf-plugin-bionic> (0m0.00s).
-----> Verifying <default-tf-plugin-bionic>...
       Loaded tests from {:path=>".Users.viviengarot.Desktop.VisualCode.skillsmap.TF.to-remove.tf-custom-plugin-mavidser-kitchen.test.integration.default"}

Profile: tests from {:path=>"/Users/viviengarot/Desktop/VisualCode/skillsmap/TF/to-remove/tf-custom-plugin-mavidser-kitchen/test/integration/default"} (tests from {:path=>".Users.viviengarot.Desktop.VisualCode.skillsmap.TF.to-remove.tf-custom-plugin-mavidser-kitchen.test.integration.default"})
Version: (not specified)
Target:  ssh://vagrant@127.0.0.1:2222

  File /home/vagrant/.terraform.d/plugins/localproviders/mavidser/linux/1.0.2/linux_amd64/terraform-provider-linux
     ✔  is expected to exist
     ✔  md5sum is expected to eq "f46802e787ae030a81a5db01d9ae254f"
     ✔  size is expected to eq 24120848
     ✔  type is expected to eq :file
     ✔  owner is expected to eq "vagrant"
     ✔  group is expected to eq "vagrant"
  Command: `terraform init --upgrade=true && terraform apply --auto-approve=true`
     ✔  stdout is expected to match /testgroup-id = "100[0-9]"/
     ✔  stdout is expected to match /testuser1-id = "100[0-9]"/
     ✔  stdout is expected to match /testuser2-id = "100[0-9]"/

Test Summary: 9 successful, 0 failures, 0 skipped
       Finished verifying <default-tf-plugin-bionic> (0m7.41s).
-----> Test Kitchen is finished. (0m8.50s)
```

* Cleanup

```
bundle exec kitchen destroy
```

_sample_:

```
bundle exec kitchen destroy
-----> Starting Test Kitchen (v3.0.0)
-----> Destroying <default-tf-plugin-bionic>...
       ==> default: Forcing shutdown of VM...
       ==> default: Destroying VM and associated drives...
       Vagrant instance <default-tf-plugin-bionic> destroyed.
       Finished destroying <default-tf-plugin-bionic> (0m4.32s).
-----> Test Kitchen is finished. (0m5.29s).
```


* _Optional_ - Test kitchen note

Instead of running the kitchen subcommands (converge, verify, destroy) individually, you can run them all at once with :

```
bundle exec kitchen test
```

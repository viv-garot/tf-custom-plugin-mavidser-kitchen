# tf-custom-plugin-mavidser-kitchen

## Description
* Learn how to run locally a custom plugin ([terraform-linux-plugin](https://github.com/mavidser/terraform-provider-linux) from mavidser) with kitchen-test

## Pre-requirements

* [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) 
* [Vagrant](https://www.vagrantup.com/downloads)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## How to use this repo

- Clone
- Run
- Cleanup

---

### Clone the repo

```
git clone https://github.com/viv-garot/tf-custom-plugin-mavidser-kitchen
```

### Change directory

```
cd tf-custom-plugin-mavidser-kitchen
```

### Create the Vagrant box with Terraform and Goland provisioned, and the custom plugin compiled.

* Run the add-box.sh scripts. (This will create a VM from the Vagrantfile, package it and finally create a suitable re-usable box required for test kitchen ).
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

* Bring up the test kitchen environment

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

* Check the instance (a.k.a platform defined in the kitchen.yml)

```
bundle exec kitchen list
```

_sample_:

```
bundle exec kitchen list
Instance                  Driver   Provisioner  Verifier  Transport  Last Action  Last Error
default-tf-plugin-bionic  Vagrant  Shell        Inspec    Ssh        Converged    <None>
```

* We are finally able to excecute the tests (configured in test/integration/default/check-plugin.rb)

### Cleanup

* Disconnect from the VM

```
exit
```

_sample_:

```
vagrant@vagrant:~$ exit
logout
Connection to 127.0.0.1 closed.
```

* Destroy the VM

```
vagrant destroy
````

_sample_:

```
vagrant destroy
    default: Are you sure you want to destroy the 'default' VM? [y/N] y
==> default: Forcing shutdown of VM...
==> default: Destroying VM and associated drives...
```

# tf-custom-plugin

## Description
* Learn how to run locally a custom plugin. ([terraform-linux-plugin](https://github.com/mavidser/terraform-provider-linux) from mavidser)
* Test it with kitchen-terraform

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

### Create the

* Run the add-box.sh scripts. (This will create a VM from the Vagrantfile, package it and create a re-usable box from it).
> This operation takes several minutes

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

### Test-kitchen

* Converge the VM

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






* Run the sample project (single null_resource):

```
terraform -chdir=/vagrant init && terraform -chdir=/vagrant apply
```

_sample_:

```
vagrant@vagrant:~$ terraform -chdir=/vagrant init && terraform -chdir=/vagrant apply

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/null from the dependency lock file
- Using previously-installed hashicorp/null v3.1.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
null_resource.null: Refreshing state... [id=2606815751610571705]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
```

* Compile the custom plugin

```
bash plugin.sh
```

_sample_

```
vagrant@vagrant:~$ bash plugin.sh
Cloning into 'terraform-provider-linux'...
remote: Enumerating objects: 160, done.
remote: Counting objects: 100% (7/7), done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 160 (delta 0), reused 5 (delta 0), pack-reused 153
Receiving objects: 100% (160/160), 65.14 KiB | 2.61 MiB/s, done.
Resolving deltas: 100% (76/76), done.
==> Checking that code complies with gofmt requirements...
go install
go: downloading github.com/hashicorp/terraform v0.12.6
go: downloading github.com/hashicorp/go-hclog v0.0.0-20181001195459-61d530d6c27f
go: downloading github.com/hashicorp/go-plugin v1.0.1-0.20190610192547-a1bc61569a26

## ...

go: downloading github.com/posener/complete v1.2.1
go: downloading golang.org/x/sys v0.0.0-20191029155521-f43be2a4598c
go: downloading google.golang.org/genproto v0.0.0-20190201180003-4b09977fb922
go: downloading github.com/satori/go.uuid v1.2.0
go: downloading github.com/googleapis/gax-go v2.0.0+incompatible
go: downloading github.com/googleapis/gax-go/v2 v2.0.3
go: downloading github.com/mattn/go-colorable v0.1.1
go: downloading github.com/google/go-cmp v0.3.0
go: downloading go.opencensus.io v0.18.0
go: downloading golang.org/x/oauth2 v0.0.0-20190220154721-9b3c75971fc9
go: downloading github.com/jmespath/go-jmespath v0.0.0-20180206201540-c2b33e8439af
vagrant@vagrant:~$
```

* Modify the terraform project to use the custom plugin

```
bash modify-main.sh
```

_sample_:

```
vagrant@vagrant:~$ bash modify-main.sh
vagrant@vagrant:~$
```

* Initialize and apply again

```
terraform -chdir=/vagrant init && terraform -chdir=/vagrant apply
```

_sample_:

```
vagrant@vagrant:~$ terraform -chdir=/vagrant init && terraform -chdir=/vagrant apply

Initializing the backend...

Initializing provider plugins...
- Finding localproviders/mavidser/linux versions matching "1.0.2"...
- Reusing previous version of hashicorp/null from the dependency lock file
- Installing localproviders/mavidser/linux v1.0.2...
- Installed localproviders/mavidser/linux v1.0.2 (unauthenticated)
- Using previously-installed hashicorp/null v3.1.0

Terraform has made some changes to the provider dependency selections recorded
in the .terraform.lock.hcl file. Review those changes and commit them to your
version control system if they represent changes you intended to make.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
null_resource.null: Refreshing state... [id=3161630483811464142]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # linux_group.testgroup will be created
  + resource "linux_group" "testgroup" {
      + gid    = (known after apply)
      + id     = (known after apply)
      + name   = "testgroup"
      + system = false
    }

  # linux_user.testuser1 will be created
  + resource "linux_user" "testuser1" {
      + gid    = (known after apply)
      + id     = (known after apply)
      + name   = "testuser1"
      + system = false
      + uid    = (known after apply)
    }

  # linux_user.testuser2 will be created
  + resource "linux_user" "testuser2" {
      + gid    = (known after apply)
      + id     = (known after apply)
      + name   = "testuser2"
      + system = false
      + uid    = (known after apply)
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + testgroup-id = (known after apply)
  + testuser1-id = (known after apply)
  + testuser2-id = (known after apply)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

linux_group.testgroup: Creating...
linux_group.testgroup: Creation complete after 0s [id=1001]
linux_user.testuser1: Creating...
linux_user.testuser2: Creating...
linux_user.testuser2: Creation complete after 0s [id=1001]
linux_user.testuser1: Creation complete after 0s [id=1002]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

testgroup-id = "1001"
testuser1-id = "1002"
testuser2-id = "1001"
```

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

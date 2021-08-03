# tf-custom-plugin

## Description
* Learn how to run locally a custom plugin. ([terraform-linux-plugin](https://github.com/mavidser/terraform-provider-linux) from mavidser)

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
git clone https://github.com/viv-garot/tf-custom-plugin-mavidser
```

### Change directory

```
cd tf-custom-plugin-mavidser
```

### Run

* Create the Virtualbox VM from VagrantFile:

```
vagrant up
```

_sample_:

```
vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'vivien/bionic64'...
==> default: Matching MAC address for NAT networking...
==> default: Checking if box 'vivien/bionic64' version '21.07.06' is up to date...
==> default: Setting the name of the VM: tf-custom-plugin_default_1627977553419_90086
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2222
    default: SSH username: vagrant
    default: SSH auth method: private key
    default:
    default: Vagrant
    
## ....

    default: go: downloading github.com/gofrs/uuid v3.3.0+incompatible
    default: go: downloading github.com/dylanmei/iso8601 v0.1.0
    default: go: downloading github.com/nu7hatch/gouuid v0.0.0-20131221200532-179d4d0c4d8d
    default: go: downloading github.com/hashicorp/golang-lru v0.5.1
    default: go: downloading github.com/masterzen/simplexml v0.0.0-20190410153822-31eea3082786
==> default: Running provisioner: file...
    default: scripts/modify-main.sh => /home/vagrant/modify-main.sh
==> default: Running provisioner: file...
    default: scripts/plugin.sh => /home/vagrant/plugin.sh
```

* Connect to the VM:

```
vagrant ssh
```

_sample_:

```
vagrant ssh
Welcome to Ubuntu 18.04.5 LTS (GNU/Linux 4.15.0-147-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
New release '20.04.2 LTS' available.
Run 'do-release-upgrade' to upgrade to it.

vagrant@vagrant:~$
```

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

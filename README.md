# tf-custom-plugin

## Description
Learn how to run locally a custom plugin

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
git clone https://github.com/viv-garot/tf-custom-plugin
```

### Change directory

```
cd tf-custom-plugin
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
go: downloading github.com/petems/terraform-provider-extip v0.1.2
go: downloading github.com/hashicorp/terraform-plugin-sdk v1.7.0
go: downloading github.com/hashicorp/go-hclog v0.9.2
go: downloading github.com/hashicorp/go-plugin v1.0.1
go: downloading github.com/zclconf/go-cty v1.2.1
go: downloading google.golang.org/grpc v1.23.0

## ...

go: downloading google.golang.org/appengine v1.6.1
go: downloading golang.org/x/sys v0.0.0-20190804053845-51ab0e2deafa
go: downloading github.com/apparentlymart/go-cidr v1.0.1
go: downloading github.com/google/uuid v1.1.1
go: downloading github.com/googleapis/gax-go/v2 v2.0.5
go: downloading github.com/mattn/go-colorable v0.1.1
go: downloading github.com/google/go-cmp v0.3.1
go: downloading go.opencensus.io v0.22.0
go: downloading github.com/jmespath/go-jmespath v0.0.0-20180206201540-c2b33e8439af
go: downloading github.com/hashicorp/golang-lru v0.5.1
make: *** No rule to make target 'build'.  Stop.
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
- Reusing previous version of localproviders/petems/extip from the dependency lock file
- Reusing previous version of hashicorp/null from the dependency lock file
- Using previously-installed localproviders/petems/extip v0.1.2
- Using previously-installed hashicorp/null v3.1.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
null_resource.null: Refreshing state... [id=2606815751610571705]

Changes to Outputs:
  + external_ip_from_aws = "80.115.14.173"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes


Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

external_ip_from_aws = "80.115.14.173"
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

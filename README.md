# Simple Terraform Introduction Kata

This kata will get a first taste of Terraform by doing the following:

* Download and install Terraform
* Create a simple Terraform configuration with Providers and Resources
* Create a plan from the configuration
* Apply the plan to providers to create a running configuration
* Modify and apply the new configuration to the running infrastructure
* Destroy the running infrastructure

## Instructions

When you complete this kata, you will know how to do the following:

* Use Terraform in a simple fashion
* Manage some simple infrastructure in a docker machine
* Know what files you create or are created by Terraform, and what they do

You should be able to complete the kata from scratch, without Googling, in
thirty minutes or less. This kata assumes you already have Docker and Virtualbox
installed on your laptop.


### Setup Toolchain
[Install Terraform](https://www.terraform.io/downloads.html)

[Simple Terraform Tutorial](https://www.katacoda.com/courses/terraform/deploy-nginx)

The tutorial invites you to do all of the work in their sandbox environment.  You
should attempt it there first.  However, also use your own Docker environment to
do the same locally.


### Create Docker machine
You will need to be running a docker machine somewhere, so Terraform has a
provider to talk to.  You can do it other ways but creating a VirtualBox
VM is one quick and easy way:

```
docker-machine create default --driver virtualbox
eval $(docker-machine env default)
```

You will need the DOCKER_HOST value to configure Terraform.  For example:

```
DOCKER_HOST="tcp://192.168.99.100:2376"
```


### Configure Terraform

Prepare a ```config.tf``` file that will 'spin up' an nginx container on your
docker-machine.  You can start from the example in the linked tutorial but you'll
need to reconfigure Terraform to use your docker-machine as the provider.


### Prepare a plan file

When you've done that, create a plan file:

```terraform plan -out config.tfplan```


### Deploy your infrastructure

Terraform will tell you about the infrastructure it's going to deploy if you apply it.
If it seems reasonable you can deploy it with:

```terraform apply```

and then confirm that your infrastructure was deployed:

```docker ps```

Notice that there is a file in your directory called ```terraform.tfstate```. 
This is your state file and you must protect it at all costs.  It's how
Terraform keeps track of the running infrastructure.  If you delete or
overwrite this file, you'll have infrastructure running with no way to
manage it from Terraform.


### Manage your infrastructure

Terraform allows you to easily manage infrastructure changes with low
friction.  Right now you will have one nginx container running.  Let's say
you want 20.

Modify your configuration file, generate an updated plan, and deploy your
new infrastructure.  Examine your docker containers to verify that the
new containers have been added.  Notice that Terraform applies the change.
It doesn't destroy the previously running infrastructure.  So, if you go from
4 containers to 5, it just deploys one more to get there.


### Destroy your infrastructure

Sadly, no infrastructure lasts forever and sometimes we have to say goodbye.

You can destroy your infrastructure with:

```terraform destroy```

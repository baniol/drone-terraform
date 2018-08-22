# Drone Terraform

Simple setup for drone.io server and agent with a custom domain.

**The current state of the setup is not production ready.**

## Prerequisites

1) You have to have a public Hosted Zone with your domain, for example `mydomain.com`. The scripts will create a DNS record set (alias), using the `drone_host` variable from the `config.tfvars` file (e.g. `drone.mydomain.com`).

2) Provide an S3 bucket for storing Terraform state - put its name in the `config.remote` file, together with a key (state filename).

3) Set up a Github OAuth app and provide Client ID and Client Secret in the `config.tfvars` file.

4) Provide a path to a public key to be able to connect to the drone instance (`config.tfvars`)

## Running the Terraform scripts

Rename the config files (remove `-template` suffix), to create `config.remote` and `config.tfvars` files and provide appropriate configuration (see the `Prerequisites` section).

```bash
terraform init -backend -backend-config=config.remote

terraform apply -var-file=config.tfvars
```

To remove the resources:

```bash
terraform destroy -var-file=config.tfvars
```

## TODOS

* Https with Let's Encrypt
* Add drone secret
* Move to private VPC with NAT
* Optional bastion
* Drone persistance


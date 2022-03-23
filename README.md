# Hunkemöller Networking Project
This repository is used for creating VPC's and configuring those VPC's for Hunkemöllers. 

## Working with this repository
This repository is using submodules. You can therefore not only use git clone, you need to clone the submodules too. To properly clone this repo please use: `git clone --recursive <project_url>`. The submodule folder is also locked to a certain commit. To update the code from a submodule, use `git submodule update --init --recursive`.

## Terraform Cloud
Any merges to the main branch of this repository will be picked up by [Terraform Cloud](https://app.terraform.io/session), where terraform plan will be run. The plan will then have to be approved by an administrator of Terraform Cloud.

Important note: you should ***never*** run terraform apply locally.

## Resources to create here
- Shared VPCs
- Firewall rules
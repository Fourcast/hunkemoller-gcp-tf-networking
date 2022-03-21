# Hunkemöller Networking Project
This repository is used for creating VPC's and configuring those VPC's for Hunkemöllers. 

## Terraform Cloud
Any merges to the main branch of this repository will be picked up by [Terraform Cloud](https://app.terraform.io/session), where terraform plan will be run. The plan will then have to be approved by an administrator of Terraform Cloud.

Important note: you should ***never*** run terraform apply locally.

## Resources to create here
- VPC's for projects
- Shared VPCs
- Firewall rules
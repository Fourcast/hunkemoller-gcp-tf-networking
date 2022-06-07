module "nat_dev" {
  source = "git@github.com:hunkemollerbv/gcp-tf-modules.git//tf-gcp-modules-nat"

  nat_name = "nat-dev"
  network  = "vpc-host"
  project  = "pj-hkm-vpc-host"
  region   = "europe-west4"
}
# Set up base VPC for Cloud Composer
module "cc_vpc" {
  #source = "./modules//tf-gcp-modules-network-vpc"
  source = "git@github.com:hunkemollerbv/gcp-tf-modules.git//tf-gcp-modules-network-vpc"

  vpc_name     = "cloud-composer-vpc"
  project      = "pj-hkm-network-data-team"
  description  = "Cloud Composer VPC"
  routing_mode = "REGIONAL"

  # Cloud composer requires two subnets
  subnets = {
    "cloud-composer-subnet" = {
      cidr_primary     = "10.5.0.0/16"
      region           = var.cc_subnets_region
      secondary_ranges = {
        "cloud-composer-pods" = {
          cidr_range = "10.64.0.0/16"
        }
        "cloud-composer-services" = {
          cidr_range = "10.30.0.0/16"
        }
      }
    }
  }
}

# Set up shared VPC for Cloud Composer
module "cc_shared_vpc" {
  #source = "./modules//tf-gcp-modules-network-xpn"
  source = "git@github.com:hunkemollerbv/gcp-tf-modules.git//tf-gcp-modules-network-xpn"

  # NOTE: These _cannot_ be variables. Need to manually enter the strings
  # NOTE: The service projects needs to have the compute api service enabled
  #           before the link is created. So make sure to add the api enablement
  #           to the depends_on field.
  host_project     = "pj-hkm-network-data-team"
  service_projects = [
    "pj-data-pipeline-devel",
    "pj-data-pipeline-staging",
    "pj-data-pipeline-prod",
    "pj-hkm-zeenea-prod",
    "pj-hkm-zeenea-dev"
  ]

  depends_on = [
    google_project_service.cc_host_compute_api,
    google_project_service.cc_service_project_dev_compute_api,
  ]
}

# HKM VPC
module "hkm_vpc" {
  #source = "./modules//tf-gcp-modules-network-vpc"
  source = "git@github.com:hunkemollerbv/gcp-tf-modules.git//tf-gcp-modules-network-vpc"

  vpc_name     = "vpc-host"
  project      = "pj-hkm-vpc-host"
  description  = "Host VPC for Hunkemoller"
  routing_mode = "REGIONAL"

  subnets = {
    "vpc-subnet" = {
      cidr_primary     = "10.5.0.0/16"
      region           = var.hkm_vpc_region
      secondary_ranges = {
        "vpc-pods" = {
          cidr_range = "10.64.0.0/16"
        }
        "vpc-services" = {
          cidr_range = "10.30.0.0/16"
        }
      }
    }
  }
}

# HKM Shared VPC
module "hkm_shared_vpc" {
  #source = "./modules//tf-gcp-modules-network-xpn"
  source = "git@github.com:hunkemollerbv/gcp-tf-modules.git//tf-gcp-modules-network-xpn"

  # NOTE: These _cannot_ be variables. Need to manually enter the strings
  # NOTE: The service projects needs to have the compute api service enabled
  #           before the link is created. So make sure to add the api enablement
  #           to the depends_on field.
  host_project     = "pj-hkm-vpc-host"
  service_projects = [
    "pj-hkm-dev",
    "pj-hkm-prod",
    "pj-hkm-qa"
  ]
}

# FIXME: These resources should be enabled through the source module
# Enable required API's for all projects
resource "google_project_service" "cc_host_compute_api" {
  project                    = google_project.pj-data-team.id
  service                    = "compute.googleapis.com"
  disable_on_destroy         = false
  disable_dependent_services = false
}

resource "google_project_service" "cc_service_project_dev_compute_api" {
  project                    = "pj-data-pipeline-devel"
  service                    = "compute.googleapis.com"
  disable_on_destroy         = false
  disable_dependent_services = false
}
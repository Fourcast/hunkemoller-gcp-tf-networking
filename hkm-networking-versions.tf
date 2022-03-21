terraform {
    backend "gcs" {
        bucket = "pj-hkm-network-management-tf-state-remote"
    }
}
terraform {
    cloud {
        organization = "hunkemoller"
        workspaces {
            name = "gcp-tf-networking"
        }
    }
}
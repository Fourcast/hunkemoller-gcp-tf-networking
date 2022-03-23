resource "google_project" "pj-data-team" {
    project_id = "pj-hkm-network-data-team"

    folder_id       = var.root_folder_id
    name            = "Data team network host"
    billing_account = var.billing_account
}
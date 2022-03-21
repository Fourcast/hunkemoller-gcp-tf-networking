# Base vars
variable "root_folder_id" {
    type        = number
    description = "Root folder ID for the networking team"
    default     = 497912679188
}

variable "billing_account" {
    type        = string
    description = "Billing accoun ID"
    default     = "014B30-10B798-064992"
}

# Cloud Composer - Basic VPC variables
variable "cc_subnets_region" {
    type = string
    description = "Region in which subnets for Cloud Composer will be created"
}
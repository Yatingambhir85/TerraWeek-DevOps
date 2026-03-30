variable "os_type" {
  description = "Choose the OS: ubuntu, amazon, or rhel"
  type        = string
  validation {
    #checks if the input is allowed in our list
    condition     = contains(["ubuntu", "amazon", "rhel"], lower(var.os_type))
    error_message = "The os_type must be one of: 'ubuntu', 'amazon', 'rhel'"
  }
}

locals {
  s3_bucket_name_final = "terra-s3-${formatdate("YYYYMMDD", time_static.today.rfc3339)}-${random_integer.suffix.result}"
}
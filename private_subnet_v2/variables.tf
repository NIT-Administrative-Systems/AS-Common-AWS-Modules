variable "vpc_id" {
  description = "VPC ID in which to allocate the IPs."
}

variable "subnet_cidr_list" {
  description = "IP blocks for multiple AZs. Minimum size is a /28"
}

variable "availability_zone_list" {
  description = "list of availability zones within the VPC"
}

variable "nat_gateway_id" {
  description = "NAT gateway ID for reaching the internet"
}

variable "label" {
  description = "Label for the subnet, e.g. docconv-dev"
}

variable "enabled" {
  description = "Whether or not to build anything at all. Useful for disabling subnet allocations in prod accounts that already have them from the pre-TF days."
  default     = "true"
}
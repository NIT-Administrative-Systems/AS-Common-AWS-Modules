variable "vpc_id" {
  description = "VPC ID in which to allocate the IPs."
}

variable "subnet_cidr_az1" {
  description = "IP block for AZ1. Minimum size is a /28."
}

variable "subnet_cidr_az2" {
  description = "IP block for AZ2. Minimum size is a /28."
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


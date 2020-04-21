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
  default = ""
}

variable "transit_gateway_id" {
  description = "Trasnit gateway ID used for routing traffic over the VPNi.   The current default is the AWS transit gateway for all accounts, but could change."
  default = "tgw-05a25479d60902394"
}

variable "transit_gw_routes" {
  description = "List of CIDRs that you want routed over the transit gateway instead of the public internet"
  default = []
}

variable "label" {
  description = "Label for the subnet, e.g. docconv-dev"
}

variable "enabled" {
  description = "Whether or not to build anything at all. Useful for disabling subnet allocations in prod accounts that already have them from the pre-TF days."
  default     = "true"
}


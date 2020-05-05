variable "vpc_id" {
  description = "VPC ID in which to allocate the IPs."
}

variable "subnet_cidr_az1" {
  description = "IP block for AZ1. Minimum size is a /28."
}

variable "subnet_cidr_az2" {
  description = "IP block for AZ2. Minimum size is a /28."
}

variable "nat_gateway_id_az1" {
  description = "NAT gateway ID for reaching the internet"
}

variable "nat_gateway_id_az2" {
  description = "NAT gateway ID for reaching the internet"
}

variable "transit_gateway_id" {
  description = "Transit gateway ID used for routing traffic over the VPN. The current default is the AWS transit gateway for all accounts, but could change."
  default = "tgw-05a25479d60902394"
}

variable "transit_gw_routes" {
  description = "List of CIDRs that you want routed over the transit gateway instead of the public internet. The default value should cover most use-cases."
  default = ["129.105.0.0/16", "165.124.0.0/16", "10.101.0.0/16", "10.105.0.0/16", "10.120.0.0/16", "10.102.0.0/15"]
}

variable "label" {
  description = "Label for the subnet, e.g. docconv-dev"
}

variable "enabled" {
  description = "Whether or not to build anything at all. Useful for disabling subnet allocations in prod accounts that already have them from the pre-TF days."
  default     = "true"
}

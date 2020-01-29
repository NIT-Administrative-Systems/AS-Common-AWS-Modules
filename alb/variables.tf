variable "region" {
  default     = "us-east-2"
  description = "AWS region to provision resources in"
}

variable "account_label" {
  description = "Account label, used to label shared resources."
}

variable "vpc_id" {
  description = "The Northwestern VPC ID for this account."
}

variable "subnets" {
  description = "Minimum of two subnet IDs for the ALB to live in. You should probably use the PubAZ1 and PubAZ2 subnets attached to your VPC."
  type        = list(string)
}


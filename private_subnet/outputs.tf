output "subnet_id_list" {
  value = var.enabled == "true" ? [element(aws_subnet.subnet_az1.*.id, 1), element(aws_subnet.subnet_az2.*.id, 1)] : []
}


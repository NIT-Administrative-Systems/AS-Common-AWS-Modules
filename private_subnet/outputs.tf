output "subnet_id_list" {
  value = [element((var.enabled == "true" ? aws_subnet.subnet_az1.*.id : []), 1), element((var.enabled == "true" ? aws_subnet.subnet_az2.*.id : []), 1)]
}


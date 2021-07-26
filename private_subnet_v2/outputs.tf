output "subnet_id_list" {
    value = {
        for k, v in aws_subnet.subnets : k => v.id
    }
}
output "subnet_id_list" {
    value = {
        for k, v in aws_subnet : k => v.id
    }
}
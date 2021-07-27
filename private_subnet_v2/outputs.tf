//    subnets is a map containing each subnet resource as another map (map of maps)
//    this isolates the inner subnet map, finds the ids, and puts them in a list
variable "subnet_id_list" {
    subnet_id_list = flatten([
    for subnet in keys(aws_subnet.subnets) : [
      for id in aws_subnet.subnets[subnet] : [
        id
        ]
      ]
    ])
}

output "subnet_id_list" {

//    value = tolist(lookup(values(aws_subnet.subnets), "id", 0))
    value = var.subnet_id_list
}
output "subnet_id_list" {
//    subnets is a map containing each subnet resource as another map (map of maps)
//    this isolates the inner subnet map, finds the ids, and puts them in a list
    value = tolist(lookup(values(aws_subnet.subnets), "id", 0))
}
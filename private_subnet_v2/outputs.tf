//    subnets is a map containing each subnet resource as another map (map of maps)
//    this isolates the inner subnet map, finds the ids, and puts them in a list

output "subnet_id_list" {
    value = tolist([ for subnet in aws_subnet.subnets : lookup(subnet, "id", 0)])
}
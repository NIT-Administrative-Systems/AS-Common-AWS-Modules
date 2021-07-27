//    subnets is a map containing each subnet resource as another map (map of maps)
//    this isolates the inner subnet map, finds the ids, and puts them in a list

output "subnet_id_list" {
//    value = tolist(lookup(values(aws_subnet.subnets), "id", 0))
    value = tolist([
      for subnet in keys(aws_subnet.subnets) : [
        for map in aws_subnet.subnets[subnet] : [
          lookup(map, "id", 0)
        ]
      ]
    ])
}
# does it matter which specific CIDR block is associated with which availability zone?
locals {
  CIDR_AZ_map = {
    value = zipmap(var.subnet_cidr_list, var.availability_zone_list)
  }
  NAT_Gateway_list = tolist(var.nat_gateway_id_list)
}

resource "aws_subnet" "subnets" {
//  this should create nothing if enabled = false, as we cannot use count and for_each
    for_each = { for  k, v in local.CIDR_AZ_map.value : k => v if var.enabled }

    vpc_id = var.vpc_id
    cidr_block = each.key
    availability_zone = each.value

    tags = {
        # I think this works instead of Az1 and Az2
        Name = "${var.label}-Pvt-${each.value}"
    }
}

resource "aws_route_table" "route_tables" {
  count = var.enabled == "true" ? length(var.nat_gateway_id_list) : 0

  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id_list[count.index]
  }

  dynamic "route" {
    for_each = var.transit_gw_routes

    content {
      cidr_block = route.value
      transit_gateway_id = var.transit_gateway_id
    }
  }
}

resource "aws_route_table_association" "route_mappings" {
  count = var.enabled ? length(var.subnet_cidr_list) : 0

  subnet_id = aws_subnet.subnets[count.index].id
  subnet_id = {for subnet in aws_subnets.subnets : subnet.id}

  //  this monstrosity takes the map of map of subnets, finds the subnet map corresponding to count.index, and isolates its id
  //  to visualize: lookup({{map_one}, {map_two}}, map_one, default) gets us to map_one = {key:value} so we do another lookup to get the value of the the key "id"
  # subnet_id = lookup(
  #   lookup(aws_subnet.subnets, keys(aws_subnet.subnets)[count.index], local.Default),
  #    "id", count.index)
  route_table_id = lookup(element(aws_route_table.route_tables, count.index), "id", 0)
}


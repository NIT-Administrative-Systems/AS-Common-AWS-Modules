# does it matter which specific CIDR block is associated with which availability zone?
locals {
  CIDR_AZ_map = {
    value = zipmap(var.subnet_cidr_list, var.availability_zone_list)
  }
}

resource "aws_subnet" "subnets" {
//  this should create nothing if enabled = false, as we cannot use count and for_each
    for_each = { for  k, v in local.CIDR_AZ_map.value : k => v if var.enabled }
//    count = "${var.enabled == "true" ? 1 : 0}"

    vpc_id = var.vpc_id
    cidr_block = each.key
    availability_zone = each.value

    tags = {
        # I think this works instead of Az1 and Az2
        Name = "${var.label}-Pvt-${each.value}"
    }
}

resource "aws_route_table" "route_tables" {
//  count = var.enabled == "true" ? 1 : 0
  for_each = toset(var.nat_gateway_id_list)

  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = each.key
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
  count = var.enabled ? length(aws_subnet.subnets) : 0

//  can't zipmap these as they have values known only after apply
//  subnet_id      = aws_subnet.subnets[count.index].id
  subnet_id      = flatten([for id in aws_subnet.subnets : {subnet_id = id}])[count]
//  route_table_id = aws_route_table.route_tables[count.index].id
  route_table_id = flatten([for id in aws_route_table.route_tables : {route_table_id = id}])[count]
}


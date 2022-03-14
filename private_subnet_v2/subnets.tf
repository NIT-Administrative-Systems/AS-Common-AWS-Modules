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


  # the for loop returns a list of ids, we use the current count to access the index of the id we want 
  subnet_id = element([for subnet in aws_subnet.subnets : subnet.id], count.index)
  route_table_id = lookup(element(aws_route_table.route_tables, count.index), "id", 0)
}

# @TODO
/**
Casey suggested inputting our subnets/AZs/NATs like this (from the shared resources IAC) so they're easier to iterate over, rather than zipping lists into maps

az_mappings = {
  az1 = {
    nat_gateway_id = "something something"
    az_id = "something something"
    cidr = "something something"
  },
  az2 = {
    nat_gateway_id = "something something"
    az_id = "something something"
    cidr = "something something"
  },
  az3 = {
    nat_gateway_id = "something something"
    az_id = "something something"
    cidr = "something something"
  }
*/

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

resource "aws_route_table" "route_table" {
//  no for_each here so we can use count
  count = var.enabled == "true" ? 1 : 0

  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }
}

resource "aws_route_table_association" "route_mappings" {
  for_each = { for  k, v in aws_subnet.subnets : k => v if var.enabled }

//  my IDE doesn't like each.value.id but I'm not sure why - or what the proper syntax would be
  subnet_id      = each.value.id
  route_table_id = aws_route_table.route_table[0].id
}


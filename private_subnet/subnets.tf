resource "aws_subnet" "subnet_az1" {
  count = var.enabled == "true" ? 1 : 0

  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_az1
  availability_zone = "us-east-2a"

  tags = {
    Name = "${var.label}-PvtAz1"
  }
}

resource "aws_subnet" "subnet_az2" {
  count = var.enabled == "true" ? 1 : 0

  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_az2
  availability_zone = "us-east-2b"

  tags = {
    Name = "${var.label}-PvtAz2"
  }
}

resource "aws_route_table" "route_table_az1" {
  count = var.enabled == "true" ? 1 : 0

  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id_az1
  }

  dynamic "route" {
    for_each = var.transit_gw_routes

    content {
      cidr_block = route.value
      transit_gateway_id = var.transit_gateway_id
    }
  }
}

resource "aws_route_table" "route_table_az2" {
  count = var.enabled == "true" ? 1 : 0

  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id_az2
  }

  dynamic "route" {
    for_each = var.transit_gw_routes

    content {
      cidr_block = route.value
      transit_gateway_id = var.transit_gateway_id
    }
  }
}

resource "aws_route_table_association" "route_mapping_az1" {
  count = var.enabled == "true" ? 1 : 0

  subnet_id      = aws_subnet.subnet_az1[0].id
  route_table_id = aws_route_table.route_table_az1[0].id
}

resource "aws_route_table_association" "route_mapping_az2" {
  count = var.enabled == "true" ? 1 : 0

  subnet_id      = aws_subnet.subnet_az2[0].id
  route_table_id = aws_route_table.route_table_az2[0].id
}


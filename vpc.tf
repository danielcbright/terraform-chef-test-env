# Get AZs
data "aws_availability_zones" "available" {}

# Main Chef VPC
resource "aws_vpc" "chef" {
  cidr_block = "${var.chef_networking["main_vpc_cidr_block"]}"
  tags = "${merge(var.default_tags, map(
    "Name", "${var.prefix}-chef_vpc",
  ))}"
}

# Chef public and private subnets
resource "aws_subnet" "chef_01_public" {
  vpc_id     = "${aws_vpc.chef.id}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  cidr_block = "${var.chef_networking["chef_01_public_cidr_block"]}"
  tags = "${merge(var.default_tags, map(
    "Name", "${var.prefix}-chef_01_public",
  ))}"
}

resource "aws_subnet" "chef_02_private" {
  vpc_id     = "${aws_vpc.chef.id}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  cidr_block = "${var.chef_networking["chef_02_private_cidr_block"]}"
  tags = "${merge(var.default_tags, map(
    "Name", "${var.prefix}-chef_02_private",
  ))}"
}

resource "aws_subnet" "chef_03_private" {
  vpc_id     = "${aws_vpc.chef.id}"
  availability_zone = "${data.aws_availability_zones.available.names[2]}"
  cidr_block = "${var.chef_networking["chef_03_private_cidr_block"]}"
  tags = "${merge(var.default_tags, map(
    "Name", "${var.prefix}-chef_03_private",
  ))}"
}

# Internet Gateway for public subnet
resource "aws_internet_gateway" "chef_gw" {
  vpc_id = "${aws_vpc.chef.id}"
  tags = "${merge(var.default_tags, map(
    "Name", "${var.prefix}-chef_internet_gateway",
  ))}"
}

# NAT Gateway for private subnet
resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.eip_nat.id}"
  subnet_id     = "${aws_subnet.chef_01_public.id}"
  tags = "${merge(var.default_tags, map(
    "Name", "${var.prefix}-chef_nat_gateway",
  ))}"
}

# Route tables
resource "aws_route_table" "chef_01_public" {
  vpc_id = "${aws_vpc.chef.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.chef_gw.id}"
  }
  tags = "${merge(var.default_tags, map(
    "Name", "${var.prefix}-chef_01_public_route_table",
  ))}"
}

resource "aws_route_table" "chef_02_private" {
  vpc_id = "${aws_vpc.chef.id}"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat.id}"
  }
  tags = "${merge(var.default_tags, map(
    "Name", "${var.prefix}-chef_02_private_route_table",
  ))}"
}

resource "aws_route_table" "chef_03_private" {
  vpc_id = "${aws_vpc.chef.id}"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat.id}"
  }
  tags = "${merge(var.default_tags, map(
    "Name", "${var.prefix}-chef_03_private_route_table",
  ))}"
}

# Route table associations
resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.chef_01_public.id}"
  route_table_id = "${aws_route_table.chef_01_public.id}"
}

resource "aws_route_table_association" "b" {
  subnet_id      = "${aws_subnet.chef_02_private.id}"
  route_table_id = "${aws_route_table.chef_02_private.id}"
}

resource "aws_route_table_association" "c" {
  subnet_id      = "${aws_subnet.chef_03_private.id}"
  route_table_id = "${aws_route_table.chef_03_private.id}"
}

resource "aws_main_route_table_association" "chef" {
  vpc_id         = "${aws_vpc.chef.id}"
  route_table_id = "${aws_route_table.chef_01_public.id}"
}

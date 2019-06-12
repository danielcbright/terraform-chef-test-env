# Get AZs
data "aws_availability_zones" "available" {}

# EIP
resource "aws_eip" "eip_nat" {
  tags = "${merge(data.terraform_remote_state.static.default_tags, map(
    "Name", "${data.terraform_remote_state.static.prefix}eip${data.terraform_remote_state.static.suffix}",
  ))}"
}

# Main VPC
resource "aws_vpc" "main" {
  cidr_block = "${var.networking["main_vpc_cidr_block"]}"
  tags = "${merge(data.terraform_remote_state.static.default_tags, map(
    "Name", "${data.terraform_remote_state.static.prefix}vpc${data.terraform_remote_state.static.suffix}",
  ))}"
}

# public and private subnets
resource "aws_subnet" "public_00" {
  vpc_id     = "${aws_vpc.main.id}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  cidr_block = "${var.networking["public_00_cidr_block"]}"
  tags = "${merge(data.terraform_remote_state.static.default_tags, map(
    "Name", "${data.terraform_remote_state.static.prefix}public_00${data.terraform_remote_state.static.suffix}",
  ))}"
}

resource "aws_subnet" "private_00" {
  vpc_id     = "${aws_vpc.main.id}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  cidr_block = "${var.networking["private_00_cidr_block"]}"
  tags = "${merge(data.terraform_remote_state.static.default_tags, map(
    "Name", "${data.terraform_remote_state.static.prefix}private_00${data.terraform_remote_state.static.suffix}",
  ))}"
}

resource "aws_subnet" "private_01" {
  vpc_id     = "${aws_vpc.main.id}"
  availability_zone = "${data.aws_availability_zones.available.names[2]}"
  cidr_block = "${var.networking["private_01_cidr_block"]}"
  tags = "${merge(data.terraform_remote_state.static.default_tags, map(
    "Name", "${data.terraform_remote_state.static.prefix}private_01${data.terraform_remote_state.static.suffix}",
  ))}"
}

# Internet Gateway for public subnet
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"
  tags = "${merge(data.terraform_remote_state.static.default_tags, map(
    "Name", "${data.terraform_remote_state.static.prefix}internet_gateway${data.terraform_remote_state.static.suffix}",
  ))}"
}

# NAT Gateway for private subnet
resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.eip_nat.id}"
  subnet_id     = "${aws_subnet.public_00.id}"
  tags = "${merge(data.terraform_remote_state.static.default_tags, map(
    "Name", "${data.terraform_remote_state.static.prefix}nat_gateway${data.terraform_remote_state.static.suffix}",
  ))}"
}

# Route tables
resource "aws_route_table" "public_00" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
  tags = "${merge(data.terraform_remote_state.static.default_tags, map(
    "Name", "${data.terraform_remote_state.static.prefix}public_00_route_table${data.terraform_remote_state.static.suffix}",
  ))}"
}

resource "aws_route_table" "private_00" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat.id}"
  }
  tags = "${merge(data.terraform_remote_state.static.default_tags, map(
    "Name", "${data.terraform_remote_state.static.prefix}private_00_route_table${data.terraform_remote_state.static.suffix}",
  ))}"
}

resource "aws_route_table" "private_01" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat.id}"
  }
  tags = "${merge(data.terraform_remote_state.static.default_tags, map(
    "Name", "${data.terraform_remote_state.static.prefix}private_01_route_table${data.terraform_remote_state.static.suffix}",
  ))}"
}

# Route table associations
resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.public_00.id}"
  route_table_id = "${aws_route_table.public_00.id}"
}

resource "aws_route_table_association" "b" {
  subnet_id      = "${aws_subnet.private_00.id}"
  route_table_id = "${aws_route_table.private_00.id}"
}

resource "aws_route_table_association" "c" {
  subnet_id      = "${aws_subnet.private_01.id}"
  route_table_id = "${aws_route_table.private_01.id}"
}

resource "aws_main_route_table_association" "rta" {
  vpc_id         = "${aws_vpc.main.id}"
  route_table_id = "${aws_route_table.public_00.id}"
}

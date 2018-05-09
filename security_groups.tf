# Admin SG
resource "aws_security_group" "chef_admin" {
  name        = "chef_admin"
  description = "Allow inbound SSH traffic to Chef Admin VPC from allowed IPs"
  vpc_id      = "${aws_vpc.chef.id}"
  tags = "${merge(var.default_tags, map(
    "Name", "${var.prefix}-chef_admin",
  ))}"
}

resource "aws_security_group_rule" "ingress_ssh_chef_admin_allowed_cidrs" {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${split(",", var.allowed_cidrs)}"]
    security_group_id = "${aws_security_group.chef_admin.id}"
}
resource "aws_security_group_rule" "ingress_https_chef_admin_allowed_cidrs" {
    type        = "ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${split(",", var.allowed_cidrs)}"]
    security_group_id = "${aws_security_group.chef_admin.id}"
}

resource "aws_security_group_rule" "egress_chef_admin" {
    type            = "egress"
    from_port       = 0
    to_port         = 0
    protocol = "-1"
    security_group_id = "${aws_security_group.chef_admin.id}"
    source_security_group_id = "${aws_security_group.chef_internal.id}"
}

resource "aws_security_group_rule" "egress_chef_admin_all" {
    type            = "egress"
    from_port       = 0
    to_port         = 0
    protocol = "-1"
    security_group_id = "${aws_security_group.chef_admin.id}"
    cidr_blocks = ["0.0.0.0/0"]
}

# Internal SG
resource "aws_security_group" "chef_internal" {
  name        = "chef_internal"
  description = "Allow all inbound traffic to Chef Internal VPC from Admin SG and SELF SG"
  vpc_id      = "${aws_vpc.chef.id}"
  tags = "${merge(var.default_tags, map(
    "Name", "${var.prefix}-chef_internal",
  ))}"
}

resource "aws_security_group_rule" "ingress_chef_internal_from_admin" {
    type            = "ingress"
    from_port       = 0
    to_port         = 0
    protocol = "-1"
    security_group_id = "${aws_security_group.chef_internal.id}"
    source_security_group_id = "${aws_security_group.chef_admin.id}"
}

resource "aws_security_group_rule" "ingress_chef_internal" {
    type            = "ingress"
    from_port       = 0
    to_port         = 0
    protocol = "-1"
    security_group_id = "${aws_security_group.chef_internal.id}"
    source_security_group_id = "${aws_security_group.chef_internal.id}"
}

resource "aws_security_group_rule" "egress_chef_internal" {
    type            = "egress"
    from_port       = 0
    to_port         = 0
    protocol = "-1"
    security_group_id = "${aws_security_group.chef_internal.id}"
    cidr_blocks = ["0.0.0.0/0"]
}

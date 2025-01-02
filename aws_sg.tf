resource "aws_security_group" "web_server_security_group" {
  name        = var.instance_security_group["name"]
  description = var.instance_security_group["description"]
}
resource "aws_vpc_security_group_ingress_rule" "sg_inbound_rules" {
  for_each          = var.security_group_rules
  security_group_id = aws_security_group.web_server_security_group.id
  cidr_ipv4         = each.value.cidr_ipv4
  from_port         = each.value.from_port
  ip_protocol       = each.value.ip_protocol
  to_port           = each.value.to_port
}

resource "aws_vpc_security_group_egress_rule" "sg_outbond_rules" {
  security_group_id = aws_security_group.web_server_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 0
  ip_protocol       = "-1"
  to_port           = 0
}



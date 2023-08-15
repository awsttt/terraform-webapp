locals {
  web_servers = {
    my-app-00 = {
      machine_type = "t3.micro"
      subnet_id    = aws_subnet.private_eu_central_1a.id
    }
    my-app-01 = {
      machine_type = "t3.micro"
      subnet_id    = aws_subnet.private_eu_central_1b.id
    }
  }
}

resource "aws_security_group" "ec2_eg1" {
  name   = "ec2-eg1"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "alb_eg1" {
  name   = "alb-eg1"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "rds_eg1" {
  name   = "rds-eg1"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "ingress_efs_traffic" {
  name   = "ingress-efs-traffic"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group_rule" "ingress_ec2_traffic" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2_eg1.id
  source_security_group_id = aws_security_group.alb_eg1.id
}

resource "aws_security_group_rule" "ingress_ec2_health_check" {
  type                     = "ingress"
  from_port                = 8081
  to_port                  = 8081
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2_eg1.id
  source_security_group_id = aws_security_group.alb_eg1.id
}

resource "aws_security_group_rule" "ingress_alb_traffic" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.alb_eg1.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "egress_alb_traffic" {
  type                     = "egress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.alb_eg1.id
  source_security_group_id = aws_security_group.ec2_eg1.id
}

resource "aws_security_group_rule" "egress_alb_health_check" {
  type                     = "egress"
  from_port                = 8081
  to_port                  = 8081
  protocol                 = "tcp"
  security_group_id        = aws_security_group.alb_eg1.id
  source_security_group_id = aws_security_group.ec2_eg1.id
}

resource "aws_security_group_rule" "ingress_rds_traffic" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_eg1.id
  source_security_group_id = aws_security_group.ec2_eg1.id
}

#NFS

resource "aws_security_group_rule" "ingress_efs_traffic" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ingress_efs_traffic.id
  source_security_group_id = aws_security_group.ec2_eg1.id
}

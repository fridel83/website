resource "aws_security_group" "nat" {
  name = "vpc_nat"
  description = "Can access both subnets"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [var.private_subnet_cidr_3a, var.private_subnet_cidr_3b, var.private_subnet_cidr_3c]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [var.private_subnet_cidr_3a, var.private_subnet_cidr_3b, var.private_subnet_cidr_3c]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.public_subnet_cidr_3a, var.public_subnet_cidr_3b, var.public_subnet_cidr_3c, var.private_subnet_cidr_3c, var.private_subnet_cidr_3b, var.private_subnet_cidr_3a]
  }
  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }
  egress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.main_vpc.id
}
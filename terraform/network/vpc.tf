resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
}

resource "aws_subnet" "eu-west-3a-public" {
  vpc_id = aws_vpc.main_vpc.id

  cidr_block = var.public_subnet_cidr_3a
  availability_zone = data.aws_availability_zones.available.names[0]

}

resource "aws_subnet" "eu-west-3b-public" {
  vpc_id = aws_vpc.main_vpc.id

  cidr_block = var.public_subnet_cidr_3b
  availability_zone =  data.aws_availability_zones.available.names[1]

}

resource "aws_subnet" "eu-west-3c-public" {
  vpc_id = aws_vpc.main_vpc.id

  cidr_block = var.public_subnet_cidr_3c
  availability_zone = data.aws_availability_zones.available.names[2]
}

resource "aws_subnet" "eu-west-3a-private" {
  vpc_id = aws_vpc.main_vpc.id

  cidr_block = var.private_subnet_cidr_3a
  availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_subnet" "eu-west-3b-private" {
  vpc_id = aws_vpc.main_vpc.id

  cidr_block = var.private_subnet_cidr_3b
  availability_zone = data.aws_availability_zones.available.names[1]

}

resource "aws_subnet" "eu-west-3c-private" {
  vpc_id = aws_vpc.main_vpc.id

  cidr_block = var.private_subnet_cidr_3c
  availability_zone = data.aws_availability_zones.available.names[2]
}

resource "aws_internet_gateway" "ig-main" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route_table" "eu-west-3-public" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig-main.id
  }
}

resource "aws_route_table_association" "eu-west-1a-public" {
  subnet_id = aws_subnet.eu-west-3a-public.id
  route_table_id = aws_route_table.eu-west-3-public.id
}

resource "aws_route_table_association" "eu-west-3b-public" {
  subnet_id = aws_subnet.eu-west-3b-public.id
  route_table_id = aws_route_table.eu-west-3-public.id
}

resource "aws_route_table_association" "eu-west-3c-public" {
  subnet_id = aws_subnet.eu-west-3c-public.id
  route_table_id = aws_route_table.eu-west-3-public.id
}

resource "aws_instance" "nat" {
  ami = "ami-0050bb60cea70c5b3"
  availability_zone = data.aws_availability_zones.available.names[0]
  instance_type = "t2.micro"
  key_name = var.aws_key_name
  vpc_security_group_ids = [aws_security_group.nat.id]
  subnet_id = aws_subnet.eu-west-3a-public.id
  associate_public_ip_address = true
  source_dest_check = false
}

resource "aws_route_table" "eu-west-3-private" {
  vpc_id = aws_vpc.main_vpc.id

  route {
  cidr_block = "0.0.0.0/0"
  instance_id = aws_instance.nat.id
  }
}

resource "aws_route_table_association" "eu-west-3a-private" {
  subnet_id = aws_subnet.eu-west-3a-private.id
  route_table_id = aws_route_table.eu-west-3-private.id
}

resource "aws_route_table_association" "eu-west-3b-private" {
  subnet_id = aws_subnet.eu-west-3b-private.id
  route_table_id = aws_route_table.eu-west-3-private.id
}

resource "aws_route_table_association" "eu-west-3c-private" {
  subnet_id = aws_subnet.eu-west-3c-private.id
  route_table_id = aws_route_table.eu-west-3-private.id
}

variable region {
  default = "eu-west-1"
}

variable vpc_cidr {
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_3a" {
  type = string
  default = "10.0.0.0/19"
}

variable "public_subnet_cidr_3b" {
  type = string
  default = "10.0.32.0/19"
}

variable "public_subnet_cidr_3c" {
  type = string
  default = "10.0.64.0/19"
}

variable "public_subnet_cidr_4" {
  type = string
  default = "10.0.96.0/19	"
}

variable "private_subnet_cidr_3c" {
  type = string
  default = "10.0.128.0/19"
}

variable "private_subnet_cidr_3b" {
  type = string
  default = "10.0.160.0/19"
}

variable "private_subnet_cidr_3a" {
  type = string
  default = "10.0.192.0/19"
}

variable "private_subnet_cidr_4" {
  type = string
  default = "10.0.224.0/19"
}

variable "aws_key_name" {
  type = string
  default = "website"
}
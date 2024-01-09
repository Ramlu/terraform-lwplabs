resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block_vpc
  instance_tenancy     = var.vpc_tenancy
  enable_dns_support   = var.dns_support_enable
  enable_dns_hostnames = var.dns_hostnames_enable
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "private_subnet" {
  for_each          = { for index, az_name in data.aws_availability_zones.this.names : index => az_name }
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block_vpc, length(data.aws_availability_zones.this.names) > 3 ? 4 : 3, each.key)
  availability_zone = each.value
  tags = {
    Name = "Private Subnet - ${each.key}"
  }
}

resource "aws_subnet" "public_subnet" {
  for_each          = { for index, az_name in data.aws_availability_zones.this.names : index + length(data.aws_availability_zones.this.names) => az_name }
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block_vpc, length(data.aws_availability_zones.this.names) > 3 ? 4 : 3, each.key)
  availability_zone = each.value
  tags = {
    Name = "Public Subnet - ${each.key}"
  }
}

# resource "aws_subnet" "subnets_az1" {
#   for_each          = { "Public Subnet 1" : "10.17.0.0/26", "Private Subnet 1" : "10.17.0.128/26" }
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = each.value
#   availability_zone = "ap-south-1a"
#   tags = {
#     Name = "${each.key}"
#   }
# }

# resource "aws_subnet" "subnets_az2" {
#   for_each          = { "Public Subnet 2" : "10.17.0.64/26", "Private Subnet 2" : "10.17.0.192/26" }
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = each.value
#   availability_zone = "ap-south-1b"
#   tags = {
#     Name = "${each.key}"
#   }
# }

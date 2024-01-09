resource "aws_vpc" "main" {
  cidr_block       = "10.17.0.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "subnets_az1" {
  for_each          = { "Public Subnet 1" : "10.17.0.0/26", "Private Subnet 1" : "10.17.0.128/26" }
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = "ap-south-1a"
  tags = {
    Name = "${each.key}"
  }
}

resource "aws_subnet" "subnets_az2" {
  for_each          = { "Public Subnet 2" : "10.17.0.64/26", "Private Subnet 2" : "10.17.0.192/26" }
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = "ap-south-1b"
  tags = {
    Name = "${each.key}"
  }
}

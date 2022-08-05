provider "aws" {
  region     = "us-east-1"
  access_key = "access_key_id"
  secret_key = "secrete_key_id"
}
resource "aws_subnet" "database-subnet-1" {
vpc_id = aws_vpc.my-vpc.id
cidr_block = "10.0.21.0/24"
availability_zone = "ap-south-1a"
tags = {
Name = "Database-1a"
}
}
resource "aws_subnet" "database-subnet-2" {
vpc_id = aws_vpc.my-vpc.id
cidr_block = "10.0.22.0/24"
availability_zone = "ap-south-1b"
tags = {
Name = "Database-2b"
}
}
resource "aws_subnet" "database-subnet" {
vpc_id = aws_vpc.my-vpc.id
cidr_block = "10.0.3.0/24"
availability_zone = "ap-south-1a"
tags = {
Name = "Database"
}
}

provider "aws" {
  region     = "us-east-1"
  access_key = "access_key_id"
  secret_key = "secrete_key_id"
}
resource "aws_subnet" "web-subnet-1" {
vpc_id = aws_vpc.my-vpc.id
cidr_block = "10.0.1.0/24"
availability_zone = "ap-south-1a"
map_public_ip_on_launch = true
tags = {
Name = "Web-1a"
}
}
resource "aws_subnet" "web-subnet-2" {
vpc_id = aws_vpc.my-vpc.id
cidr_block = "10.0.2.0/24"
availability_zone = "ap-south-1b"
map_public_ip_on_launch = true
tags = {
Name = "Web-2b"
}
}

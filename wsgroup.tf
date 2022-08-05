provider "aws" {
  region     = "us-east-1"
  access_key = "access_key_id"
  secret_key = "secrete_key_id"
}
# Create Web Security Group
resource "aws_security_group" "web-sg" {
name = "Web-SG"
description = "Allow HTTP inbound traffic"
vpc_id = aws_vpc.my-vpc.id
ingress {
description = "HTTP from VPC"
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
tags = {
Name = "Web-SG"
}
}

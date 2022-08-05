provider "aws" {
  region     = "us-east-1"
  access_key = "access_key_id"
  secret_key = "secrete_key_id"
}
# Create Application Security Group
resource "aws_security_group" "webserver-sg" {
name = "Webserver-SG"
description = "Allow inbound traffic from ALB"
vpc_id = aws_vpc.my-vpc.id
ingress {
description = "Allow traffic from web layer"
from_port = 80
to_port = 80
protocol = "tcp"
security_groups = [aws_security_group.web-sg.id]
}
egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
tags = {
Name = "Webserver-SG"
}
}

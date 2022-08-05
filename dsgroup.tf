provider "aws" {
  region     = "us-east-1"
  access_key = "access_key_id"
  secret_key = "secrete_key_id"
}
#Create Database Security Group
resource "aws_security_group" "database-sg" {
name = "Database-SG"
description = "Allow inbound traffic from application layer"
vpc_id = aws_vpc.my-vpc.id
ingress {
description = "Allow traffic from application layer"
from_port = 3306
to_port = 3306
protocol = "tcp"
security_groups = [aws_security_group.webserver-sg.id]
}
egress {
from_port = 32768
to_port = 65535
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
tags = {
Name = "Database-SG"
}
}
resource "aws_lb" "external-elb" {
name = "External-LB"
internal = false
load_balancer_type = "application"
security_groups = [aws_security_group.web-sg.id]
subnets = [aws_subnet.web-subnet-1.id, aws_subnet.web-subnet-2.id]
}
resource "aws_lb_target_group" "external-elb" {
name = "ALB-TG"
port = 80
protocol = "HTTP"
vpc_id = aws_vpc.my-vpc.id
}
resource "aws_lb_target_group_attachment" "external-elb1" {
target_group_arn = aws_lb_target_group.external-elb.arn
target_id = aws_instance.webserver1.id
port = 80
depends_on = [
aws_instance.webserver1,
]
}
resource "aws_lb_target_group_attachment" "external-elb2" {
target_group_arn = aws_lb_target_group.external-elb.arn
target_id = aws_instance.webserver2.id
port = 80
depends_on = [
aws_instance.webserver2,
]
}
resource "aws_lb_listener" "external-elb" {
load_balancer_arn = aws_lb.external-elb.arn
port = "80"
protocol = "HTTP"
default_action {
type = "forward"
target_group_arn = aws_lb_target_group.external-elb.arn
}
}
resource "aws_db_instance" "default" {
allocated_storage = 10
db_subnet_group_name = aws_db_subnet_group.default.id
engine = "mysql"
engine_version = "8.0.20"
instance_class = "db.t2.micro"
multi_az = true
name = "mydb"
username = "username"
password = "password"
skip_final_snapshot = true
vpc_security_group_ids = [aws_security_group.database-sg.id]
}
resource "aws_db_subnet_group" "default" {
name = "main"
subnet_ids = [aws_subnet.database-subnet-1.id, aws_subnet.database-subnet-2.id]
tags = {
Name = "My DB subnet group"
}
}
output "lb_dns_name" {
description = "The DNS name of the load balancer"
value = aws_lb.external-elb.dns_name
}

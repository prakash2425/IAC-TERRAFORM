provider "aws" {
  region     = "us-east-1"
  access_key = "access_key_id"
  secret_key = "secrete_key_id"
}
resource "aws_route_table_association" "a" {
subnet_id = aws_subnet.web-subnet-1.id
route_table_id = aws_route_table.web-rt.id
}
resource "aws_route_table_association" "b" {
subnet_id = aws_subnet.web-subnet-2.id
route_table_id = aws_route_table.web-rt.id
}

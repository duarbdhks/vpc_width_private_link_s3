resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.dev_vpc.id
  service_name = "com.amazonaws.ap-northeast-2.s3"
}

resource "aws_vpc_endpoint_route_table_association" "private_route_table_association" {
  route_table_id  = aws_route_table.dev_private_route_table.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}
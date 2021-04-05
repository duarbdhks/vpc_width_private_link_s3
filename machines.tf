resource "aws_key_pair" "web_admin" {
  key_name   = "web_admin"
  public_key = file("~/.ssh/web_admin.pub")
}

resource "aws_instance" "public_instance" {
  ami                    = var.public_instance
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.dev_subnet_public.id
  iam_instance_profile   = aws_iam_instance_profile.ec2profile.name
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.dev_security_group_public.id]
  tags = {
    Name = "dev-public-1"
  }
}

resource "aws_instance" "private_instance" {
  ami = var.private_instance
  instance_type = "t2.micro"
  subnet_id = aws_subnet.dev_subnet_private.id
  iam_instance_profile = aws_iam_instance_profile.ec2profile.name
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.dev_security_group_private.id]
  tags = {
    Name = "dev-private-1"
  }
}
resource "aws_rds_cluster" "example" {
  cluster_identifier = "example"
  engine = "aurora-postgresql"
  engine_version = "10.12"
  db_subnet_group_name = aws_db_subnet_group.example.name
  master_username = "example"
  master_password = "example"
  vpc_security_group_ids = [aws_security_group.example.id]
}

resource "aws_security_group" "example" {
  name = "example"
  description = "example"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "example" {
  name = "example"
  subnet_ids = [aws_subnet.example.id]
  tags = {
    Name = "example"
  }
}

resource "aws_subnet" "example" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-west-2a"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "private_eu_central_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    "Name" = "private-eu-central-1a"
  }
}

resource "aws_subnet" "private_eu_central_1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    "Name" = "private-eu-central-1b"
  }
}

resource "aws_subnet" "public_eu_central_1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "public-eu-central-1a"
  }
}

resource "aws_subnet" "public_eu_central_1b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "public-eu-central-1b"
  }
}

resource "aws_subnet" "subnet-efs" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.5.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = false
}

resource "aws_db_subnet_group" "rds_db_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.private_eu_central_1a.id, aws_subnet.private_eu_central_1b.id]
}

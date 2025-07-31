/**-------------
- VPC
- Subnet
- IGW
- Route Table
-------------*/

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    name = "${var.project_name}-${var.environment}-vpc"
    environment = var.environment
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    name = "${var.project_name}-${var.environment}-igw"
    environment = var.environment
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets_cidr)
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnets_cidr[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    name = "${var.project_name}-${var.environment}-public-subnet-${count.index + 1}"
    environment = var.environment
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets_cidr)
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnets_cidr[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    name = "${var.project_name}-${var.environment}-private-subnet-${count.index + 1}"
    environment = var.environment
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    name = "${var.project_name}-${var.environment}-public-rt"
    environment = var.environment
  }
}

# Public Route (IGWへのデフォルトルート)
resource "aws_route" "public_internet_gateway" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
}

# Public SubnetとPublic Route Tableへの紐づけ
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  # AZ事に１つずつ（削除予定？）
  count = length(var.private_subnets_cidr)
  vpc_id = aws_vpc.main.id

  tags = {
    name = "${var.project_name}-${var.environment}-private-rt-${count.index + 1}"
    environment = var.environment
  }
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
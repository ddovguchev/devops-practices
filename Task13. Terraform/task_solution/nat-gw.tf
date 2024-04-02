resource "aws_eip" "main" {
  tags = {
    Name = "${terraform.workspace}-ngw-ip"
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = module.vpc_creator.public_subnets.bastion_host.id

  tags = {
    Name = "${terraform.workspace}-ngw"
  }
}

resource "aws_route_table" "private" {
  vpc_id = module.vpc_creator.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "${terraform.workspace}-rtb-ngw"
  }
}

resource "aws_route_table_association" "private" {
  for_each = module.vpc_creator.private_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

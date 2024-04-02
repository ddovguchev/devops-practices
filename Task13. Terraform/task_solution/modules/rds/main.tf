resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow traffic to RDS"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  tags = {
    Name = "${var.workspace}-sg-RDS"
  }
}

resource "aws_db_subnet_group" "rds_subnet" {
  name       = "${var.workspace}-subnet-group-rds"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "db_instance" {
  allocated_storage   = var.allocated_storage
  storage_type        = var.storage_type
  engine              = "postgres"
  engine_version      = "15"
  instance_class      = var.instance_class
  skip_final_snapshot = true

  username = var.username
  password = var.password
  port     = var.port

  db_subnet_group_name = aws_db_subnet_group.rds_subnet.id
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  publicly_accessible  = false

  tags = {
    Name = "${var.workspace}-RDS"
  }

  lifecycle {
    create_before_destroy = true
  }
}
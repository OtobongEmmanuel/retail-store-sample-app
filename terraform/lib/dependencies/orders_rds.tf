resource "aws_db_instance" "orders_db" {
  identifier     = "${var.environment_name}-orders"
  engine         = "postgres"
  engine_version = "18.3"

  instance_class = "db.t4g.micro"

  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = "orders"
  username = "ordersadmin"
  password = random_string.orders_db_master.result

  db_subnet_group_name   = aws_db_subnet_group.orders.name
  vpc_security_group_ids = [aws_security_group.orders_rds.id]

  publicly_accessible     = false
  skip_final_snapshot     = true
  backup_retention_period = 1

  tags = var.tags
}

resource "aws_db_subnet_group" "orders" {
  name       = "${var.environment_name}-orders-rds"
  subnet_ids = var.subnet_ids

  tags = var.tags
}

resource "aws_security_group" "orders_rds" {
  name   = "${var.environment_name}-orders-rds"
  vpc_id = var.vpc_id

  tags = var.tags
}

resource "aws_security_group_rule" "orders_rds_ingress" {
  type      = "ingress"
  from_port = 5432
  to_port   = 5432
  protocol  = "tcp"

  security_group_id        = aws_security_group.orders_rds.id
  source_security_group_id = var.orders_security_group_id
}

resource "random_string" "orders_db_master" {
  length  = 10
  special = false
}

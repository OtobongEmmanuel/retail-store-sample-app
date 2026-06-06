resource "aws_db_instance" "catalog_db" {
  identifier     = "${var.environment_name}-catalog"
  engine         = "mysql"
  engine_version = "8.4.8"
  instance_class = "db.t4g.micro"

  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = "catalog"
  username = "catalogadmin"
  password = random_string.catalog_db_master.result

  db_subnet_group_name   = aws_db_subnet_group.catalog.name
  vpc_security_group_ids = [aws_security_group.catalog_rds.id]

  publicly_accessible     = false
  skip_final_snapshot     = true
  backup_retention_period = 1

  tags = var.tags
}

resource "aws_db_subnet_group" "catalog" {
  name       = "${var.environment_name}-catalog-rds"
  subnet_ids = var.subnet_ids

  tags = var.tags
}

resource "aws_security_group" "catalog_rds" {
  name   = "${var.environment_name}-catalog-rds"
  vpc_id = var.vpc_id

  tags = var.tags
}

resource "aws_security_group_rule" "catalog_rds_ingress" {
  type      = "ingress"
  from_port = 3306
  to_port   = 3306
  protocol  = "tcp"

  security_group_id        = aws_security_group.catalog_rds.id
  source_security_group_id = var.catalog_security_group_id
}

resource "random_string" "catalog_db_master" {
  length  = 10
  special = false
}

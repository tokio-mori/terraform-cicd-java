provider "aws" {
    region = var.aws_region
}

module "vpc" {
  source = "../../modules/vpc"
  project_name = var.project_name
  environment = "dev"
  vpc_cidr = "10.0.0.0/16"
  public_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets_cidr = ["10.0.11.0/24", "10.0.12.0/24"]
  availability_zones = var.availability_zones
}

# Security Groupモジュールの呼び出し
module "security_group" {
  source             = "../../modules/security_group"
  project_name       = var.project_name
  environment        = "dev"
  vpc_id             = module.vpc.vpc_id
  db_port            = 3306 # MySQLの場合
  ssh_ingress_cidr_blocks = ["0.0.0.0/0"] # 開発用なので許可範囲を広く (本番では制限)
}

# EC2モジュールの呼び出し
module "ec2" {
  source                    = "../../modules/ec2"
  project_name              = var.project_name
  environment               = "dev"
  ami_id                    = "ami-04158184f60ea8b5e"
  instance_type             = "t2.micro"
  subnet_id                 = module.vpc.public_subnet_ids[0] # パブリックサブネットに配置
  security_group_id         = module.security_group.ec2_security_group_id
  key_pair_name             = "test-keypair"
  associate_public_ip       = true # パブリックIPを割り当てる
}

# RDSモジュールの呼び出し
module "rds" {
  source             = "../../modules/rds"
  project_name       = var.project_name
  environment        = "dev"
  private_subnet_ids = module.vpc.private_subnet_ids
  security_group_id  = module.security_group.rds_security_group_id
  db_engine          = "mysql" # または "postgres"
  db_engine_version  = "8.0"   # または "15.4" (PostgreSQLの場合)
  db_instance_class  = "db.t3.micro"
  db_allocated_storage = 5
  db_name            = "${var.project_name}_dev_db"
  db_username        = "admin"
  db_password        = "DEV_PASSWORD" # 本番環境ではTerraform Vaultなどを使うべき
  db_port            = 3306
  multi_az           = false # 開発環境では通常false
}
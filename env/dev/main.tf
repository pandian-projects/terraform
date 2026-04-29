module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr    = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
  vpc_name    = var.vpc_name
  managed_by  = var.managed_by
  my_ip       = var.my_ip
}

module "ec2" {
  source = "../../modules/ec2"

  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = module.vpc.subnet_id
  sg_id         = module.vpc.sg_id
  key_name      = var.key_name
  vpc_name      = var.vpc_name
  managed_by    = var.managed_by
}
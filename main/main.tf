provider "aws" {
  region = "ap-southeast-3"
}

module "key_pair" {
  source = "./modules/key_pair"
  key_name = "dellkey"
  public_key_path = "~/.ssh/id_ed25519.pub"
}

module "security_group" {
  source = "./modules/security_group"
  name = "hello-api-sg"
  description = "Allow inbound traffics for ssh and api"
  vpc_id = module.vpc.vpc_id
  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 3000
      to_port     = 3000
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "vpc" {
  source = "./modules/vpc"
  name = "hello-vpc"
  vpc_cidr = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  availability_zone = "ap-southeast-3a"
}

module "ec2-instance" {
  source = "./modules/ec2-instance"
  ami = "ami-052ae27e2f9f3674f"
  name = "hello-api"
  subnet_id = module.vpc.public_subnet_id
  key_name = module.key_pair.key_name
  private_key_path = "~/.ssh/id_ed25519"
  security_group_ids = [ module.security_group.security_group_id ]
}
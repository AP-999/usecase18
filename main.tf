provider "aws" {
  region = "eu-central-1"
}

module "vnet" {
  source     = "./modules/vnet"
  cidr_block = "10.0.0.0/16"
}

module "subnets" {
  source = "./modules/subnets"
  vpc_id = module.vnet.vpc_id
  subnets = {
    public = {
      cidr   = "10.0.1.0/24"
      public = true
      name   = "public-subnet"
    },
    private = {
      cidr   = "10.0.2.0/24"
      public = false
      name   = "private-subnet"
    }
  }
}

module "vm" {
  source = "./modules/vm"
  ami    = "ami-04e601abe3e1a910f" # Replace with a valid AMI ID
  instances = {
    vm_public = {
      subnet_id = module.subnets.subnet_ids["public"]
      name      = "VM-Public"
    },
    vm_private = {
      subnet_id = module.subnets.subnet_ids["private"]
      name      = "VM-Private"
    }
  }
}


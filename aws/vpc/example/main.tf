 provider "vault" {
  address = "https://vault-public-vault-fde0a779.3a7f5db6.z1.hashicorp.cloud:8200"
  }

data "vault_generic_secret" "aws_credentials" {
  path = "kv/aws_credentials"
} 

provider "aws" {
  region = "eu-west-1"

  access_key = data.vault_generic_secret.aws_credentials.data["access_key"]
  secret_key = data.vault_generic_secret.aws_credentials.data["secret_key"] 
}

module "vpc" {
  source  = "app.terraform.io/SecureBankAE/vpc/aws"
  version = "1.3.0"

  vpc_parameters = {
    vpc1 = {
      cidr_block = "10.0.0.0/16"
    }
  }
  subnet_parameters = {
    subnet1 = {
      cidr_block = "10.0.1.0/24"
      vpc_name   = "vpc1"
    }
  }
  igw_parameters = {
    igw1 = {
      vpc_name = "vpc1"
    }
  }
  rt_parameters = {
    rt1 = {
      vpc_name = "vpc1"
      routes = [{
        cidr_block = "0.0.0.0/0"
        gateway_id = "igw1"
        }
      ]
    }
  }
  rt_association_parameters = {
    assoc1 = {
      subnet_name = "subnet1"
      rt_name     = "rt1"
    }
  }
}

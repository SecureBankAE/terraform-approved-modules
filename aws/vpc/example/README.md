# VPC creation

The guide how to use the template should be here


# operational guide

https://int.securebank.com/terraform/aws/vpc


# service owner

John Johnson john.johnson@securebank.com

# architecture

https://int.jira.securebank.com/terraform/aws/vpc

# required parameters

main.tf:
- pc_parameters = {
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




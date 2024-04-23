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
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "my-s3-bucket-ae-12345"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}
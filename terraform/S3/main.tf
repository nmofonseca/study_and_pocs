#### Locals ####
locals {
  region = "us-east-1"
  bucket_name = "s3-temp-state-bucket-${random_pet.randomnum.id}"

  common_tags = {
    Managedby = "Terraform"
    For         = "TF State"
  }

}

#data "aws_caller_identity" "current" {}

resource "random_pet" "randomnum" {
  length = 2
}


resource "aws_kms_key" "s3objects" {
  description             = "KMS key is used to encrypt bucket objects"
  deletion_window_in_days = 7
  tags = merge(
    local.common_tags,
    {
      Name      = "tfstate-bucket-kms-key"
      Component = "KMS"
    }
  )
}

module "state_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.6.1"

  bucket = local.bucket_name

  force_destroy = true

  acl    = "private"


  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true


  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = aws_kms_key.s3objects.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  
  tags = merge(
    local.common_tags,
    {
      Name      = "tfstate-bucket"
      Component = "s3"
    }
  )

}

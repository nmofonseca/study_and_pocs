
Code from my experiments with the Terraform AWS S3 module.

GitHub module  link:  [VPC Module ](https://github.com/terraform-aws-modules/terraform-aws-s3-bucket)
Terraform Registry Link: [Registry - VPC Module](https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest) 

## Usage

I used this code to create a S3 bucket for Terraform state but a creation of a bucket for anything can be done using the same code

For Terraform State using S3 it's a chicken and egg situation, so I use the code first to create the bucket and then just rename the backend file back to **backend.tf** and update with the fresh bucket name

To move the local state to the bucket you just need to run

```bash
terraform init
```

Terraform will ask if a copy of the state to the new back-end is what we want, it's as simple as to say YES!!! and that's it, your state will be stored in the bucket from now on.

The back-end is not being configured with locking

To  use the code just use the commands:

```bash

# To initialize Terraform
terraform init

# To format 
terraform fmt

#To validate the syntax
terraform validate

# To execute plan
terraform plan

# To apply the code
terraform apply

```

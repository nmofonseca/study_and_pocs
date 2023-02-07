
Code from my experiments with the Terraform AWS VPC module.

GitHub module  link:  [VPC Module ](https://github.com/terraform-aws-modules/terraform-aws-vpc)

Terraform Registry Link: [Registry - VPC Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest) 

The code present here was for my specific experiment but it can be very easily modified for other architectures

In my scenario I needed to have not only public and private subnets but also a couple of smaller subnets just for EKS to place the ENI's that are needed for K8s Control plane communication

Everything here has  been picked up from the module GitHub  repository [examples](https://github.com/terraform-aws-modules/terraform-aws-vpc/tree/master/examples) 

In certain areas the code is also a little bit over the top, as e.g. just for testing/experimenting wouldn't need that many subnets spread across 3 availability zones, however this was done for testing eksctl so for EKS you need at least 2 subnets

### Usage

```bash
# Initialise
terraform init

# Validate
terraform validate

# Plan
terraform plan 

# Apply
terraform apply

# Destroy
terraform destroy 
# If you would like to plan the destroy first use terraform plan -destroy
```

#### Tagging

There is some tagging that is specific for EKS, remove or add more as your pleasure
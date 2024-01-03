
Experimenting with eksctl to create EKS clusters.

The VPC and subnets that I will be using come from the VPC module present in this repository, so the eksctl deployment will be on custom networking mode, won't use the VPC creation capabilities of eksctl.

In this example I am using specific subnets for the control plane and specific subnets for the worker nodes

All the technical details on how to use the tool has been picked up from the eksctl [website](https://eksctl.io/)  

I also wanted to use a config file instead of passing arguments in the command-line


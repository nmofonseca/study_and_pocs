terraform {
  backend "s3" {
    bucket = "s3-temp-state-bucket-set-buzzard"
    key    = "terraform-vpc.state"
    region = "us-east-1"
  }
}   
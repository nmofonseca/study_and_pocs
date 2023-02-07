terraform {
  backend "s3" {
    bucket = "s3-temp-state-bucket-selected-monitor"
    key    = "terraform-vpc.state"
    region = "us-east-1"
  }
}   
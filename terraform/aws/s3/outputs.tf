
output "state_bucket_name" {
  description = "S3 bucket ARN for terraform state"
  value       = module.state_bucket.s3_bucket_id
}

output "state_bucket_arn" {
  description = "S3 bucket ARN for terraform state"
  value       = module.state_bucket.s3_bucket_arn
}

output "state_bucket_key_arn" {
  description = "Arn of the KMS key created for S3 bucket encryption"
  value       = aws_kms_key.s3objects.arn
}

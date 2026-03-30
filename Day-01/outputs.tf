output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.my_instance.public_ip
}

output "public_dns" {
  description = "The public DNS name of the EC2 instance"
  value       = aws_instance.my_instance.public_dns
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket created"
  value       = local.s3_bucket_name_final
}
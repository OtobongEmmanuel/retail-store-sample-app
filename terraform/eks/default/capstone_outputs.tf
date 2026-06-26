output "cluster_name" {
  description = "EKS Cluster Name"
  value       = module.retail_app_eks.eks_cluster_id
}

output "cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value       = module.retail_app_eks.cluster_endpoint
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.inner.vpc_id
}

output "region" {
  description = "AWS Region"
  value       = "us-east-1"
}

output "assets_bucket_name" {
  description = "Assets Bucket Name"
  value       = aws_s3_bucket.assets.bucket
}

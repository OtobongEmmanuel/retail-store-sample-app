terraform {
  backend "s3" {
    bucket = "project-bedrock-tfstate-altsoe0254655"
    key    = "eks/default/terraform.tfstate"
    region = "us-east-1"
  }
}

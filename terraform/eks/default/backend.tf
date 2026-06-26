terraform {
  backend "s3" {
    bucket = "project-bedrock-tfstate-650679031703"
    key    = "eks/default/terraform.tfstate"
    region = "us-east-1"
  }
}

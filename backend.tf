# Store the Terraform State File in S3 and lock with DynamoDB
terraform {
  backend "s3" {
    bucket         = "noonum-terraform-tfstate"
    key            = "noonum-terraform-tfstate/aws-infra-acube/tarraform.tfstate"
    region         = "us-east-1"
    profile        = "default"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}
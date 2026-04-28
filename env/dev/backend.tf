terraform {
  backend "s3" {
    bucket         = "terraform-state-iam-hacker-26-apr"
    key            = "vpc-ec2/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}
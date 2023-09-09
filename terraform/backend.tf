terraform {
  backend "s3" {
    bucket         = "simple-flask-bucket"
    key            = "./terraform.tfstate"
    dynamodb_table = "simple-flask-dynamodb-table"
    region         = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.14.0"
    }
  }
}

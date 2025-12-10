terraform {
  backend "s3" {
    bucket = "ziad-infraterraform-state-simple"
    key    = "lambda/terraform.tfstate"   # different key for prod
    region = "eu-west-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

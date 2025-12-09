provider "aws" {
  region = "eu-west-1"
}

# Reference the existing VPC remote state
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "ziad-infraterraform-state-simple"
    key    = "infra/terraform.tfstate"
    region = "eu-west-1"
  }
}

resource "aws_lambda_function" "lambda_test" {
  function_name = "lambda-test"
  runtime       = "python3.13"
  handler       = "lambda_function.lambda_handler"
  role          = "arn:aws:iam::724772084347:role/s3-allow-access"
  memory_size   = 128
  timeout       = 3
  package_type  = "Zip"

  ephemeral_storage {
    size = 512
  }

  logging_config {
    log_group  = "/aws/lambda/lambda-test"
    log_format = "Text"
  }

  tracing_config {
    mode = "PassThrough"
  }

  vpc_config {
    subnet_ids         = [data.terraform_remote_state.vpc.outputs.private_subnet_id]
    security_group_ids = ["sg-0c53e2bc1c2751d0f"]
  }

  # Use S3 for the Lambda code
  s3_bucket = "lambda-artifacts-ziad"           # bucket name
  s3_key    = "lambda/lambda.zip"               # path to object in S3
  
}

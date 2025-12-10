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

########################################
# Lambda 1 (Test VPC)
########################################
resource "aws_lambda_function" "lambda1_test" {
  function_name = "lambda1-test"
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
    log_group  = "/aws/lambda/lambda1-test"
    log_format = "Text"
  }

  tracing_config {
    mode = "PassThrough"
  }

  vpc_config {
    subnet_ids         = [data.terraform_remote_state.vpc.outputs.test_private_subnet_id]
    security_group_ids = [data.terraform_remote_state.vpc.outputs.test_lambda_sg_id]
  }

  s3_bucket = "lambda-artifacts-ziad"
  s3_key    = "lambda/lambda1.zip"
}

########################################
# Lambda 2 (Test VPC)
########################################
resource "aws_lambda_function" "lambda2_test" {
  function_name = "lambda2-test"
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
    log_group  = "/aws/lambda/lambda2-test"
    log_format = "Text"
  }

  tracing_config {
    mode = "PassThrough"
  }

  vpc_config {
    subnet_ids         = [data.terraform_remote_state.vpc.outputs.test_private_subnet_id]
    security_group_ids = [data.terraform_remote_state.vpc.outputs.test_lambda_sg_id]
  }

  s3_bucket = "lambda-artifacts-ziad"
  s3_key    = "lambda/lambda2.zip"
}

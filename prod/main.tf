provider "aws" {
  region = "eu-west-1"
}

data "terraform_remote_state" "vpc_prod" {
  backend = "s3"
  config = {
    bucket = "ziad-infraterraform-state-simple"
    key    = "infra/terraform.tfstate"
    region = "eu-west-1"
  }
}

########################################
# Lambda 1 (Prod VPC)
########################################
data "aws_s3_bucket_object" "lambda1_code" {
  bucket = "lambda-prod-artifacts-ziad"   # updated bucket
  key    = "lambda/lambda1.zip"
}

resource "aws_lambda_function" "lambda1_prod" {
  function_name = "lambda1-prod"
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
    log_group  = "/aws/lambda/lambda1-prod"
    log_format = "Text"
  }

  tracing_config {
    mode = "PassThrough"
  }

  vpc_config {
    subnet_ids         = [data.terraform_remote_state.vpc_prod.outputs.prod_private_subnet_id]
    security_group_ids = [data.terraform_remote_state.vpc_prod.outputs.prod_lambda_sg_id]
  }

  s3_bucket        = data.aws_s3_bucket_object.lambda1_code.bucket
  s3_key           = data.aws_s3_bucket_object.lambda1_code.key
  source_code_hash = data.aws_s3_bucket_object.lambda1_code.etag
}

########################################
# Lambda 2 (Prod VPC)
########################################
data "aws_s3_bucket_object" "lambda2_code" {
  bucket = "lambda-prod-artifacts-ziad"   # updated bucket
  key    = "lambda/lambda2.zip"
}

resource "aws_lambda_function" "lambda2_prod" {
  function_name = "lambda2-prod"
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
    log_group  = "/aws/lambda/lambda2-prod"
    log_format = "Text"
  }

  tracing_config {
    mode = "PassThrough"
  }

  vpc_config {
    subnet_ids         = [data.terraform_remote_state.vpc_prod.outputs.prod_private_subnet_id]
    security_group_ids = [data.terraform_remote_state.vpc_prod.outputs.prod_lambda_sg_id]
  }

  s3_bucket        = data.aws_s3_bucket_object.lambda2_code.bucket
  s3_key           = data.aws_s3_bucket_object.lambda2_code.key
  source_code_hash = data.aws_s3_bucket_object.lambda2_code.etag
}

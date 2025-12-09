output "lambda_arn" {
  value = aws_lambda_function.lambda_test.arn
}

output "lambda_name" {
  value = aws_lambda_function.lambda_test.function_name
}

output "lambda_vpc_subnet" {
  value = aws_lambda_function.lambda_test.vpc_config[0].subnet_ids
}

output "lambda_security_group" {
  value = aws_lambda_function.lambda_test.vpc_config[0].security_group_ids
}

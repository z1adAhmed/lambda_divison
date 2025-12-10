########################################
# Outputs
########################################
output "lambda1_arn" {
  value = aws_lambda_function.lambda1_test.arn
}

output "lambda1_name" {
  value = aws_lambda_function.lambda1_test.function_name
}

output "lambda1_vpc_subnet" {
  value = aws_lambda_function.lambda1_test.vpc_config[0].subnet_ids
}

output "lambda1_security_group" {
  value = aws_lambda_function.lambda1_test.vpc_config[0].security_group_ids
}

output "lambda2_arn" {
  value = aws_lambda_function.lambda2_test.arn
}

output "lambda2_name" {
  value = aws_lambda_function.lambda2_test.function_name
}

output "lambda2_vpc_subnet" {
  value = aws_lambda_function.lambda2_test.vpc_config[0].subnet_ids
}

output "lambda2_security_group" {
  value = aws_lambda_function.lambda2_test.vpc_config[0].security_group_ids
}
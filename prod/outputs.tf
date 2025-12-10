########################################
# Outputs
########################################
output "lambda1_prod_arn" {
  value = aws_lambda_function.lambda1_prod.arn
}

output "lambda1_prod_name" {
  value = aws_lambda_function.lambda1_prod.function_name
}

output "lambda1_prod_vpc_subnet" {
  value = aws_lambda_function.lambda1_prod.vpc_config[0].subnet_ids
}

output "lambda1_prod_security_group" {
  value = aws_lambda_function.lambda1_prod.vpc_config[0].security_group_ids
}

output "lambda2_prod_arn" {
  value = aws_lambda_function.lambda2_prod.arn
}

output "lambda2_prod_name" {
  value = aws_lambda_function.lambda2_prod.function_name
}

output "lambda2_prod_vpc_subnet" {
  value = aws_lambda_function.lambda2_prod.vpc_config[0].subnet_ids
}

output "lambda2_prod_security_group" {
  value = aws_lambda_function.lambda2_prod.vpc_config[0].security_group_ids
}

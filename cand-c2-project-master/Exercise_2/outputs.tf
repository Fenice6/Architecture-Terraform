# TODO: Define the output variable for the lambda function.
output "lambda_function_name" {
  value       = aws_lambda_function.udacity_lambda.function_name
  description = "The lambda function name."
  sensitive   = false
}
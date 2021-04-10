provider "aws" {
region = var.aws_region
profile = "admin"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "udacity_lambda" {
  filename      = "greet_lambda.py.zip"
  function_name = "udacity_lambda"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "greet_lambda.lambda_handler"
  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs
  ]

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("greet_lambda.py.zip"))}"
  source_code_hash = filebase64sha256("greet_lambda.py.zip")

  runtime = "python3.8"

  environment {
    variables = {
      greeting = "Hi all"
    }
  }
}
resource "aws_lambda_function" "this" {
  function_name = var.lambda_function_name
  handler = var.lambda_handler
  runtime = var.lambda_runtime
  role = aws_iam_role.lambda_role.arn
  filename = var.zip_filename
  source_code_hash = filebase64sha256(var.zip_filename)

  environment {
    variables = var.environment_variables
  }
}

resource "aws_iam_role" "lambda_role" {
    name = "${var.lambda_function_name}_role"
    assume_role_policy = jsonencode({
        Version = "2008-10-17"
        Statement = [
        {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
                Service = "lambda.amazonaws.com"
            }
        }
        ]
    })
}
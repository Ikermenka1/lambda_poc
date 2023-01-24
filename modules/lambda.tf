resource "aws_lambda_function" "lambda" {
  function_name = format("%s-%s-%s", local.prefix, var.lambda_name,  var.environment)
  runtime = "nodejs16.x"
  handler = "index.handler"
  role = aws_iam_role.lambda_exec.arn
  timeout = 5
  environment {
    variables = {
      example_variable = "dev"
    }
  }
  source_code_hash = filebase64sha256("index.zip")
  filename = "index.zip"
}

resource "aws_iam_role_policy" "lambda_etl_role" {
  name = format("%s-%s-lambda-etl-role", local.prefix, var.environment)
  role = aws_iam_role.lambda_etl_role.id
  policy = data.aws_iam_policy_document.lambda_assume_role.json
}

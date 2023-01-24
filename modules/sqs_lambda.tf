resource "aws_sqs_queue" "example" {
  name = "example"
}

resource "aws_lambda_function" "example_processor" {
  function_name = "example_processor"
  runtime = "nodejs12.x"
  handler = "index.handler"
  role = aws_iam_role.lambda_exec.arn
  timeout = 300
  environment {
    variables = {
      example_variable = "example_value"
    }
  }
  source_code_hash = filebase64sha256("index.zip")
  filename = "index.zip"
  
  # SQS trigger configuration
  event_source_mappings = [
    {
      batch_size = 10
      event_source_arn = aws_sqs_queue.example.arn
      starting_position = "TRIM_HORIZON"
    }
  ]
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_exec" {
  name = "lambda_exec"
  role = aws_iam_role.lambda_exec.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:*"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "sqs:*"
      ],
      "Resource": aws_sqs_queue.example.arn
    }
  ]
}
EOF
}

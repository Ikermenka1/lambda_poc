resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

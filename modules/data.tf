 // Policy Documents
#  data "aws_iam_policy_document" "lambda_policy_iam_policy_document"
#   statement {
#     actions = [

#     ]
#     resources = [
      
#     ]
#   }

  data "aws_iam_policy_document" "lambda_role_iam_policy_document" {
    statement {
      actions = [
        "sts:AssumeRole"
      ]
      principals {
        type = "Service"
        identifiers = ["lambda.amazonaws.com"]
      }
    }
  }
  data "aws_iam_policy_document" "lambda_assume_role" {
    statement {
      effect = "Allow"
      actions = ["sts:AssumeRole"]
      principals {
        type = "Service"
        identifiers = ["lambda.amazonaws.com"]
      }
    }
  }

  

#  <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "lambda.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF


<<EOF
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
        "s3:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
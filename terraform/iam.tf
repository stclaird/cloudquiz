resource "aws_iam_role" "cloudquiz_lambda_role" {
  name = "cloudquiz_lambda"
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

resource "aws_iam_policy_attachment" "cloudquiz-attach" {
  name       = "cloudquiz-attachment"
  roles      = ["${aws_iam_role.cloudquiz_lambda_role.name}"]
  policy_arn = "${aws_iam_policy.cloudquiz_lambda_policy.arn}"
}

resource "aws_iam_policy" "cloudquiz_lambda_policy" {
  name        = "cloudquiz_lambda_policy"
  path        = "/"
  description = "Lambda Access policy"

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
                "dynamodb:ListTables",
                "dynamodb:GetItem",
                "dynamodb:BatchGetItem",
                "dynamodb:BatchWriteItem",
                "dynamodb:PutItem",
                "dynamodb:Scan",
                "dynamodb:UpdateItem",
                "dynamodb:Query",
                "dynamodb:GetRecords"
            ],
            "Resource": "${aws_dynamodb_table.cloud-quiz.arn}"

        }
    ]
}
EOF
}


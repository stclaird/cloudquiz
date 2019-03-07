
resource "aws_lambda_function" "cloudquiz_questions" {
  function_name    = "cloudquiz_questions"
  filename         = "../lambda/cloudquiz_questions/get/build/main.zip"
  handler          = "main.lambda_handler"
  runtime          = "python3.6"
  role             = "${aws_iam_role.cloudquiz_lambda_role.arn}"

  }



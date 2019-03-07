resource "aws_api_gateway_rest_api" "cloud_quiz" {
  name        = "cloud_quiz"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_method" "cloud_quiz" {
  rest_api_id   = "${aws_api_gateway_rest_api.cloud_quiz.id}"
  resource_id   = "${aws_api_gateway_resource.cloud_quiz.id}"
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_resource" "cloud_quiz" {
  rest_api_id = "${aws_api_gateway_rest_api.cloud_quiz.id}"
  parent_id   = "${aws_api_gateway_rest_api.cloud_quiz.root_resource_id}"
  path_part   = "cloud_quiz"
}

resource "aws_api_gateway_integration" "cloud_quiz_method-integration" {
  rest_api_id = "${aws_api_gateway_rest_api.cloud_quiz.id}"
  resource_id = "${aws_api_gateway_resource.cloud_quiz.id}"
  http_method = "${aws_api_gateway_method.cloud_quiz.http_method}"
  type = "AWS_PROXY"
  uri = "arn:aws:apigateway:${var.aws_default_region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.aws_default_region}:${var.account_id}:function:${aws_lambda_function.cloudquiz_questions.function_name}/invocations"
  integration_http_method = "POST"
}

resource "aws_api_gateway_method_response" "options_200" {
    rest_api_id   = "${aws_api_gateway_rest_api.cloud_quiz.id}"
    resource_id   = "${aws_api_gateway_resource.cloud_quiz.id}"
    http_method   = "${aws_api_gateway_method.cloud_quiz.http_method}"
    status_code   = "200"
    response_models {
        "application/json" = "Empty"
    }
    response_parameters {
        "method.response.header.Access-Control-Allow-Headers" = true,
        "method.response.header.Access-Control-Allow-Methods" = true,
        "method.response.header.Access-Control-Allow-Origin" = true
    }
    depends_on = ["aws_api_gateway_method.cloud_quiz"]
}

resource "aws_api_gateway_integration_response" "cloud_quiz_options_integration_response" {
    rest_api_id   = "${aws_api_gateway_rest_api.cloud_quiz.id}"
    resource_id   = "${aws_api_gateway_resource.cloud_quiz.id}"
    http_method   = "${aws_api_gateway_method.cloud_quiz.http_method}"
    status_code   = "${aws_api_gateway_method_response.options_200.status_code}"
    response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
        "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
        "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }
    depends_on = ["aws_api_gateway_method_response.options_200"]
}

resource "aws_api_gateway_deployment" "cloudquiz_prod" {

  rest_api_id = "${aws_api_gateway_rest_api.cloud_quiz.id}"
  stage_name = "api"
  }

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "Allowcloud_quizInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.cloudquiz_questions.id}"
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.cloud_quiz.execution_arn}/*/*/*"
}

resource "aws_api_gateway_deployment" "cloudquiz_deployment" {
  depends_on = ["aws_api_gateway_integration.cloud_quiz_method-integration"]

  rest_api_id = "${aws_api_gateway_rest_api.cloud_quiz.id}"
  stage_name  = "api"

}

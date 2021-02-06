resource "aws_lambda_function" "lambda_start" {
    filename         = data.archive_file.lambda_file_start.output_path
    function_name    = var.lambda_function_start_name
    role             = aws_iam_role.role.arn
    handler          = var.lambda_handler_start
    timeout          = var.lambda_timeout
    source_code_hash = data.archive_file.lambda_file_start.output_base64sha256
    runtime          = "python3.8"
}

data "archive_file" "lambda_file_start" {
    type = "zip"

    source_file = "start_instances.py"
    output_path = "start_instances.zip"
}

resource "aws_lambda_function" "lambda_stop" {
    filename         = data.archive_file.lambda_file_stop.output_path
    function_name    = var.lambda_function_stop_name
    role             = aws_iam_role.role.arn
    handler          = var.lambda_handler_stop
    timeout          = var.lambda_timeout
    source_code_hash = data.archive_file.lambda_file_stop.output_base64sha256
    runtime          = "python3.8"
}

data "archive_file" "lambda_file_stop" {
    type = "zip"

    source_file = "stop_instances.py"
    output_path = "stop_instances.zip"
}

resource "aws_lambda_permission" "allow_cloudwatch_start_cron" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_start.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.start.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_stop_cron" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_stop.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.stop.arn
}

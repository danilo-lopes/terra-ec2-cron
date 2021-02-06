resource "aws_cloudwatch_event_rule" "start" {
    name                = var.cloudwatch_event_rule_start_name
    description         = var.cloudwatch_event_rule_start_description
    schedule_expression = "cron(0 1 * * ? *)"
}

resource "aws_cloudwatch_event_target" "start" {
    rule      = aws_cloudwatch_event_rule.start.name
    target_id = "ScheduleStartInstance"
    arn       = aws_lambda_function.lambda_start.arn
}

resource "aws_cloudwatch_event_rule" "stop" {
    name                = var.cloudwatch_event_rule_stop_name
    description         = var.cloudwatch_event_rule_stop_description
    schedule_expression = "cron(30 10 * * ? *)"
}

resource "aws_cloudwatch_event_target" "stop" {
    rule      = aws_cloudwatch_event_rule.stop.name
    target_id = "ScheduleStopInstance"
    arn       = aws_lambda_function.lambda_stop.arn
}

resource "aws_cloudwatch_log_group" "start" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_start.function_name}"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "stop" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_stop.function_name}"
  retention_in_days = 14
}

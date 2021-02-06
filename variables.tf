variable iam_role_name {
  type        = string

  default     = "EC2CronScheduleRole"
  description = "IAM Role Name"
}

variable iam_role_description {
    type = string

    default = "IAM Role for poweron/poweroff EC2 instances with lambda automation"
    description = "EC2CronScheduleRole Description"
}

variable iam_policy_name {
  type        = string

  default     = "EC2CronSchedulePolicy"
  description = "IAM Policy Name"
}

variable iam_policy_description {
  type        = string

  default     = "IAM Policy with necessary privileges to poweron/poweroff EC2 instances"
  description = "EC2CronSchedulePolicy description"
}

variable lambda_function_start_name {
  type        = string

  default     = "EC2ScheduleLambdaStart"
  description = "Lambda function name who starts instances"
}

variable lambda_function_stop_name {
  type        = string

  default     = "EC2ScheduleLambdaStop"
  description = "Lambda function name who stop instances"
}

variable lambda_handler_start {
  type        = string

  default     = "start_instances.lambda_handler"
  description = "How lambda run the program"
}

variable lambda_handler_stop {
  type        = string

  default     = "stop_instances.lambda_handler"
  description = "How lambda run the program"
}

variable lambda_timeout {
  type        = string
  default     = "10"
}

variable cloudwatch_event_rule_start_name {
  type        = string

  default     = "EC2ScheduleStartCron"
  description = "Cloudwatch event rule name"
}

variable cloudwatch_event_rule_start_description {
  type        = string

  default     = "Event Rule to trigger the lambda who starts EC2 Instaces"
  description = "EC2ScheduleStartCron description"
}

variable cloudwatch_event_rule_stop_name {
  type        = string

  default     = "EC2ScheduleStopCron"
  description = "Cloudwatch event rule name"
}

variable cloudwatch_event_rule_stop_description {
  type        = string
  default     = "Event Rule to trigger the lambda who stop EC2 Instaces"
  description = "EC2ScheduleStopCron description"
}

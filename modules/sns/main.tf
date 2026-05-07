resource "aws_sns_topic" "tf_drift" {
  name = var.sns_topic_name
}

resource "aws_sns_topic_subscription" "tf_drift_notification" {
  topic_arn = aws_sns_topic.tf_drift.arn
  protocol  = var.sns_protocol
  endpoint  = var.endpoint
}
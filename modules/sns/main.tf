resource "aws_sns_topic" "tf_drift" {
  name = var.sns-topic-name
}

resource "aws_sns_topic_subscription" "tf_drift_notification" {
  topic_arn = aws_sns_topic.tf_drift
  protocol  = var.sns-protocol
  endpoint  = "j.pandian04@gmail.com"   
}
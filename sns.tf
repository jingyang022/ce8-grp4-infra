resource "aws_sns_topic" "topic" {
  name   = "s3-event-notification-topic"
  policy = data.aws_iam_policy_document.topic.json
}

/*
resource "aws_sns_topic_subscription" "email-target" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "email"
  endpoint  = "yllee9127@gmail.com"
  endpoint_auto_confirms = true
}
*/

resource "aws_sns_topic_subscription" "email-target" {
  for_each = toset(["yllee9127@gmail.com", "yeo.kangchyi080@gmail.com", "thisisweixiong@gmail.com", "ngzirong1984@gmail.com", "rvf_7585@hotmail.com"])
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "email"
  endpoint  = each.value
  endpoint_auto_confirms = true
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.ce8-grp4-s3-bucket.id

  topic {
    topic_arn     = aws_sns_topic.topic.arn
    events        = ["s3:ObjectCreated:*"]
    # filter_suffix = ".log"
  }
}

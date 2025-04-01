#Create SNS topic
resource "aws_sns_topic" "ce8-grp4-dev-topic" {
  name = "dev-TextProcess-Completed"
}

resource "aws_sns_topic_subscription" "email-target" {
  for_each = toset(["yllee9127@gmail.com", "jingyang022@yahoo.com.sg"])
  topic_arn = aws_sns_topic.ce8-grp4-dev-topic.arn
  protocol  = "email"
  endpoint  = each.value
  endpoint_auto_confirms = true
}

resource "aws_sns_topic_subscription" "dev-sns-trigger-lambda" {
  topic_arn = aws_sns_topic.ce8-grp4-dev-topic.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.dev-func2.arn
}

# Creating an IAM Role AWS SNS Access
resource "aws_iam_role" "dev_textract_exec_role" {
 name = "dev-textract-FullAccessRole"
  assume_role_policy = jsonencode({
   Version = "2012-10-17",
   Statement = [
     {
       Action = "sts:AssumeRole",
       Principal = {
         Service = "textract.amazonaws.com"
       },
       Effect = "Allow"
     }
   ]
 })
}

resource "aws_iam_role_policy_attachment" "TextractServiceRole" {
 role       = aws_iam_role.dev_textract_exec_role.name
 policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonTextractServiceRole"
}

resource "aws_iam_role_policy_attachment" "SNS_FullAccess" {
 role       = aws_iam_role.dev_textract_exec_role.name
 policy_arn = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
}
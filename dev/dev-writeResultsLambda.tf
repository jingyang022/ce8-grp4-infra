data "archive_file" "dev-lambda2-file" {
 type        = "zip"
 source_file = "dev-writeResultsToS3.py"
 output_path = "dev-writeResultsToS3.zip"
}

resource "aws_lambda_permission" "allow_SNS" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.dev-func2.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.ce8-grp4-dev-topic.arn
}

resource "aws_lambda_function" "dev-func2" {
 function_name = "dev-writeResultsFunction"
 role          = aws_iam_role.dev_lambda2_exec_role.arn
 handler       = "dev-writeResultsToS3.lambda_handler"
 runtime       = "python3.13"
 filename      = data.archive_file.dev-lambda2-file.output_path
}

# aws_cloudwatch_log_group to get the logs of the Lambda execution.
resource "aws_cloudwatch_log_group" "dev_lambda2_log_group" {
 name              = "/aws/lambda/dev-lambda2-logs"
 retention_in_days = 14
}

# Create IAM role for WriteResultsLambda function
resource "aws_iam_role" "dev_lambda2_exec_role" {
 name = "dev-WriteResultsLambda-role"
  assume_role_policy = jsonencode({
   Version = "2012-10-17",
   Statement = [
     {
       Action = "sts:AssumeRole",
       Principal = {
         Service = "lambda.amazonaws.com"
       },
       Effect = "Allow"
     }
   ]
 })
}

resource "aws_iam_role_policy_attachment" "lambda2_basic_execution" {
 role       = aws_iam_role.dev_lambda2_exec_role.name
 policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda2_S3_FullAccess" {
 role       = aws_iam_role.dev_lambda2_exec_role.name
 policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda2_textract_FullAccess" {
 role       = aws_iam_role.dev_lambda2_exec_role.name
 policy_arn = "arn:aws:iam::aws:policy/AmazonTextractFullAccess"
}


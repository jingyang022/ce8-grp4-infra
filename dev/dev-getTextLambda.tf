# Define an archive_file datasource that creates the lambda archive
data "archive_file" "dev-lambda1-file" {
 type        = "zip"
 source_file = "dev-getTextFunction.py"
 output_path = "dev-getTextFunction.zip"
}

resource "aws_lambda_permission" "dev_lambda1_allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.dev-func1.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.ce8-grp4-dev-bucket.arn
}

resource "aws_lambda_function" "dev-func1" {
 function_name = "dev-getTextFunction"
 role          = aws_iam_role.dev_lambda1_exec_role.arn
 handler       = "dev-getTextFunction.lambda_handler"
 runtime       = "python3.13"
 filename      = data.archive_file.dev-lambda1-file.output_path
}

# aws_cloudwatch_log_group to get the logs of the Lambda execution.
resource "aws_cloudwatch_log_group" "dev_lambda1_log_group" {
 name              = "/aws/lambda/dev-lambda1-logs"
 retention_in_days = 14
}

# Create IAM role for getTextLambda funcition 
resource "aws_iam_role" "dev_lambda1_exec_role" {
 name = "dev-getTextLambda-role"
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

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
 role       = aws_iam_role.dev_lambda1_exec_role.name
 policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda1_S3_FullAccess" {
 role       = aws_iam_role.dev_lambda1_exec_role.name
 policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda1_textract_FullAccess" {
 role       = aws_iam_role.dev_lambda1_exec_role.name
 policy_arn = "arn:aws:iam::aws:policy/AmazonTextractFullAccess"
}
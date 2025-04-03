resource "aws_s3_bucket" "ce8-grp4-dev-bucket" {
  bucket = "ce8-grp4-dev-bucket"
}

resource "aws_s3_bucket_ownership_controls" "ce8-grp4-dev-bucket-controls" {
  bucket = aws_s3_bucket.ce8-grp4-dev-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "ce8-grp4-dev-bucket-public-access" {
  bucket = aws_s3_bucket.ce8-grp4-dev-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "ce8-grp4-dev-bucket-acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.ce8-grp4-dev-bucket-controls,
    aws_s3_bucket_public_access_block.ce8-grp4-dev-bucket-public-access,
  ]

  bucket = aws_s3_bucket.ce8-grp4-dev-bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_notification" "dev_bucket_notification" {
  bucket = aws_s3_bucket.ce8-grp4-dev-bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.dev-func1.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.dev_lambda1_allow_bucket]
}

resource "aws_s3_object" "upload_png" {
  bucket = aws_s3_bucket.ce8-grp4-dev-bucket.id
  key    = "images/singapore_bg.png"  # Path inside the bucket
  source = "singapore_bg.png"          # Path to local file
  content_type = "image/png"

  depends_on = [aws_s3_bucket.ce8-grp4-dev-bucket]
}



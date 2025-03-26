resource "aws_s3_bucket" "ce8-grp4-s3-bucket" {
  bucket = "ce8-grp4-bucket"
}

resource "aws_s3_bucket_ownership_controls" "ce8-grp4-s3-controls" {
  bucket = aws_s3_bucket.ce8-grp4-s3-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "ce8-grp4-s3-public-access" {
  bucket = aws_s3_bucket.ce8-grp4-s3-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "ce8-grp4-s3-acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.ce8-grp4-s3-controls,
    aws_s3_bucket_public_access_block.ce8-grp4-s3-public-access,
  ]

  bucket = aws_s3_bucket.ce8-grp4-s3-bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.ce8-grp4-s3-bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.func1.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}
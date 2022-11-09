
resource "aws_ssm_parameter" "ssm_s3_name" {
  name = "${var.environment}-s3-name"
  type = "String"
  value = aws_s3_bucket.images.bucket
}

resource "aws_ssm_parameter" "ssm_upload_role" {
  name = "${var.environment}-upload-role"
  type = "String"
  value = aws_iam_role.upload_s3_bucket.arn
}

resource "aws_ssm_parameter" "ssm_download_role" {
  name = "${var.environment}-download-role"
  type = "String"
  value = aws_iam_role.download_s3_bucket.arn
}

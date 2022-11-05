

resource "aws_s3_bucket" "hello" {
  bucket = "${var.environment}-${var.bucket_name}"
}
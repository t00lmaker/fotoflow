

resource "aws_s3_bucket" "images" {
  bucket = "${var.environment}-${var.bucket_name}"
}
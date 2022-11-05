
resource "aws_iam_role" "upload_s3_bucket" {
  name = "${var.environment}-s3-upload"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  managed_policy_arns = [
    aws_iam_policy.upload-s3-bucket.arn
  ]
}

resource "aws_iam_policy" "upload-s3-bucket" {
  name = "${var.environment}-upload-s3-bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [ 
          "s3:PutObject",
          "s3:PutObjectAcl"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = [ 
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}



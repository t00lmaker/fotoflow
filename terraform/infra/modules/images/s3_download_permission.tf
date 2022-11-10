resource "aws_iam_role" "download_s3" {
  name = "${var.environment}-s3-download"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
				  Service = "lambda.amazonaws.com",
				  AWS = "arn:aws:sts::183768142245:assumed-role/dev-s3-download/api-dev-download" 
			  }
      }
    ]
  })

  managed_policy_arns = [
    aws_iam_policy.download-s3.arn
  ]
}

resource "aws_iam_policy" "download-s3" {
  name = "${var.environment}-download"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [ 
          "s3:GetObject",
          "s3:GetObjectVersion"
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
      }
    ]
  })
}



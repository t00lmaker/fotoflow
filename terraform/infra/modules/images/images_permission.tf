resource "aws_iam_role" "images_download" {
  name = "${var.environment}-images-download"

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
    aws_iam_policy.lambda_execution.arn,
    aws_iam_policy.images_download.arn
  ]
}

resource "aws_iam_policy" "images_download" {
  name = "${var.environment}-images-download"

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
      }
    ]
  })
}



resource "aws_iam_role" "images_upload" {
  name = "${var.environment}-images-upload"

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
    aws_iam_policy.lambda_execution.arn,
    aws_iam_policy.images_upload.arn
  ]
}

resource "aws_iam_policy" "images_upload" {
  name = "${var.environment}-images-upload"

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
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_execution" {
  name = "${var.environment}-images-lambda-execution"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
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






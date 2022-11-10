resource "aws_iam_role" "job_db_permission" {
  name = "${var.environment}-job-db-permission"


  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
				  Service = "lambda.amazonaws.com"
			  }
      }
    ]
  })

  managed_policy_arns = [
    aws_iam_policy.job_db_permission.arn
  ]
}


resource "aws_iam_policy" "job_db_permission" {
  name = "${var.environment}-job-db-permission"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [ 
          "dynamodb:PutItem",
        ]
        Effect   = "Allow"
        Resource = aws_dynamodb_table.jobs.arn
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
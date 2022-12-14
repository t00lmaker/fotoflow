resource "aws_iam_role" "job_db_write_permission" {
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
    aws_iam_policy.lambda_execution.arn,
    aws_iam_policy.job_db_write_permission.arn
  ]
}


resource "aws_iam_policy" "job_db_write_permission" {
  name = "${var.environment}-job-db-write-permission"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [ 
          "dynamodb:PutItem"
        ]
        Effect   = "Allow"
        Resource = aws_dynamodb_table.jobs.arn
      }
    ]
  })
}


resource "aws_iam_role" "job_db_read_permission" {
  name = "${var.environment}-job-db-read-permission"


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
    aws_iam_policy.lambda_execution.arn,
    aws_iam_policy.job_db_read_permission.arn
  ]
}

resource "aws_iam_policy" "job_db_read_permission" {
  name = "${var.environment}-job-db-read-permission"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "dynamodb:GetItem",
          "dynamodb:BatchGetItem",
          "dynamodb:Scan",
          "dynamodb:Query",
          "dynamodb:ConditionCheckItem"
        ]
        Effect   = "Allow"
        Resource = aws_dynamodb_table.jobs.arn
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_execution" {
  name = "${var.environment}-lambda-execution"

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
      },
    ]
  })
}
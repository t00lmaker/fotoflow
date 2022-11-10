resource "aws_ssm_parameter" "dynamodb_job_table" {
  name = "${var.environment}-dynamodb-job-table"
  type = "String"
  value = aws_dynamodb_table.jobs.name
}

resource "aws_ssm_parameter" "job_db_permission" {
  name = "${var.environment}-job-db-permission"
  type = "String"
  value = aws_iam_role.job_db_permission.arn
}
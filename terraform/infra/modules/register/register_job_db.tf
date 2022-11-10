resource "aws_dynamodb_table" "jobs" {
  name = "${var.environment}-jobs"
  hash_key = "id"

  attribute {
    name = "id"
    type = "S"
  }
  
  # attribute {
  #   name = "name"
  #   type = "S"
  # }

  # attribute {
  #   name = "description"
  #   type = "S"
  # }

  # attribute {
  #   name = "bucket"
  #   type = "S"
  # }

  # attribute {
  #   name = "prefix"
  #   type = "S"
  # }

  write_capacity = var.job_table_write_capacity
  read_capacity = var.job_table_read_capacity
}
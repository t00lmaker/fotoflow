

module "images" {
  source = "../../infra/modules/images"
  environment = var.environment
  bucket_name = "fotoflow-images"
}

module "register" {
  source = "../../infra/modules/register"
  environment = var.environment

 job_table_write_capacity = 1
 job_table_read_capacity = 1
}

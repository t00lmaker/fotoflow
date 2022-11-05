

module "upload" {
  source = "../../infra/modules/upload"
  environment = var.environment
  bucket_name = "fotoflow-images"
}
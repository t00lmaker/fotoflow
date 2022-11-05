

module "s3" {
  source = "../../infra/modules/hello"
  environment = var.environment
  bucket_name = "hello-first-122"
}
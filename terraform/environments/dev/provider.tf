terraform {
  required_version = ">= 0.11"
  // backend          "s3"             {}
  
}

provider "aws" {
  default_tags {
    tags = {
      Environment = "dev"
      Origin      = "fotoflow"
      Owner       = "ops"
    }
  }
}
 
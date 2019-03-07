provider "aws" {
  region = "${var.aws_default_region}"
}

terraform {
backend "s3" {
  bucket  = "statebucket"
  key     = "key/tf-state"
  region  = "us-west-2"
  }
}

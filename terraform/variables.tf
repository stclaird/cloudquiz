
variable "aws_default_region" {
	default = "us-west-2" //your region
}

variable "account_id" {
  default = "123456789" //your aws account
}

variable "s3_bucket" {
  default = "some-bucket" //your s3 bucket
}

variable "dynamodb_table" {
  default = "some-table" //your dynamodb-table
}

variable "dynamodb_read_capacity" {
  default = 1
}

variable "dynamodb_write_capacity" {
  default = 1
}

variable "dynamodb_hash_key" {
  default = "category"
}
  
variable "dynamodb_range_key" {
  default = "id"
}

variable "aws_route53_zone" {
  default = "" // your route53 zone if
}

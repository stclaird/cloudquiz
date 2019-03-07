resource "aws_s3_bucket" "b" {
  bucket = "${var.s3_bucket}"
  acl    = "public-read"

   website {
    index_document = "index.html"
    error_document = "error.html"
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["https://${var.s3_bucket}"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

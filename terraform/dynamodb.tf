resource "aws_dynamodb_table" "cloud-quiz" {
  name           = "${var.dynamodb_table}"
  billing_mode   = "PROVISIONED"
  read_capacity  = "${var.dynamodb_read_capacity}"
  write_capacity = "${var.dynamodb_write_capacity}"
  hash_key       = "${var.dynamodb_hash_key}"
  range_key      = "${var.dynamodb_range_key}"

  attribute {
    name = "${var.dynamodb_hash_key}"
    type = "S"
  }

  attribute {
    name = "${var.dynamodb_range_key}"
    type = "N"
  }

  tags = {
    Name = "${var.dynamodb_table}"
  }
}

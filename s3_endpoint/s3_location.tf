resource "aws_s3_bucket" "bucket_name" {
  bucket = "${var.bucket_name}"
  acl    = "private"

  tags {
    Name        = "${var.bucket_name}"
    Environment = "${var.environment}"
  }
}

resource "aws_s3_bucket" "one" {
  bucket = "udayasri.1020.moonobucket"
}

resource "aws_s3_bucket_ownership_controls" "two" {
  bucket = aws_s3_bucket.one.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "three" {
  depends_on = [aws_s3_bucket_ownership_controls.two]

  bucket = aws_s3_bucket.one.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "three" {
bucket = aws_s3_bucket.one.id
versioning_configuration {
status = "Enabled"
}
}

terraform {
backend "s3" {
region = "ap-southeast-2"
bucket = "udayasri.1020.moonobucket"
key = "prod/terraform.tfstate"
}
}




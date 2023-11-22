resource "aws_s3_bucket" "practice" {
  bucket = var.name

  tags = {
    Name        = var.name
    Environment = var.environment
  }
}

resource "aws_s3_object" "html_files" {
  for_each = fileset(var.files, "**/*")

  bucket = aws_s3_bucket.practice.id
  key    = each.value
  source = "${var.files}/${each.value}"
  etag   = filebase64("${var.files}/${each.value}")
}

resource "aws_s3_bucket_website_configuration" "static-website" {
  bucket = aws_s3_bucket.practice.id

  index_document {
    suffix = var.file
  }

  error_document {
    key = var.file
  }
}

resource "aws_s3_bucket_versioning" "my-static-website" {
  bucket = aws_s3_bucket.practice.id
  versioning_configuration {
    status = "Enabled"
  }
}

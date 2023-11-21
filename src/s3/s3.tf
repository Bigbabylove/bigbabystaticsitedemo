resource "aws_s3_bucket" "practice" {
  bucket = "practice_12345_sudo"

  tags = {
    Name        = var.name
    Environment = var.environment
  }
}
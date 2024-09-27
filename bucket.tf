resource "aws_s3_bucket" "cloups" {
  bucket = "cloudops-bucket-stage"

  tags = {
    Name        = "cloudops-bucket"
    Environment = "stage"
  }
}
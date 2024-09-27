terraform {
  backend "s3" {
    bucket = "alpha-582"
    key    = "cloudops/stage/statefile"
    region = "eu-west-1"
  }
}

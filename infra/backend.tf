terraform {
  backend "s3" {
    bucket = "infra.example.com"
    key    = "infra/lambda"
    region = "us-east-1"
  }
}

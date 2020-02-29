provider "aws" {
  region = "us-east-1"
}

resource "aws_lambda_function" "aws_lambda_example_function" {
  function_name = "${var.environment}-lambda-terraform"
  s3_bucket     = "terraform-lambda-2"
  s3_key        = "${var.build_version}/build.zip"
  handler       = "index.handler"
  runtime       = "nodejs12.x"
  role          = aws_iam_role.lambda_exec.arn
}

resource "aws_iam_role" "lambda_exec" {
  name = "${var.environment}-lambda-terraform-tut"

  assume_role_policy = <<EOF
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Action":"sts:AssumeRole",
         "Principal":{
            "Service":"lambda.amazonaws.com"
         },
         "Effect":"Allow",
         "Sid":""
      }
   ]
}
EOF
}

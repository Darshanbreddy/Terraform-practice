#this is S3 bucket creation using terraform


resource aws_s3_bucket s3_bucket {

	bucket = "hani-terraform-s3-bucket"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "my-bucket"
  
}

resource "aws_s3_bucket_object" "index_html" {
  bucket = aws_s3_bucket.bucket.id
  key    = "index.html"
  source = "path/to/index.html"
}
resource "aws_s3_bucket" "ecommerce_bucket" {
  bucket  = "ecommercebucket-${var.environment}"
  tags    = {
	Name          = "ecommercebucket-${var.environment}"
	Environment    = var.environment
  }
}

resource "aws_s3_bucket_policy" "ecommerce_bucket_policy" {
  bucket = aws_s3_bucket.ecommerce_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicRead"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.ecommerce_bucket.arn}/*"
      }
    ]
  })
}


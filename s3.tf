resource "aws_s3_bucket" "my_bucket" {
  bucket  = "ecommercebucket"
  tags    = {
	Name          = "ecommercebucket"
	Environment    = "Production"
  }
}


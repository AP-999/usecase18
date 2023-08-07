
terraform {
  backend "s3" {
    bucket         = "usecase18-terraform-backend-bucket-v3"
    key            = "state/terraform.tfstate"
    dynamodb_table = "state-lock"
    region         = "eu-central-1"
    encrypt        = true
  }
}


resource "aws_s3_bucket" "terraform_backend_v3" {
  bucket = "usecase18-terraform-backend-bucket-v3"
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform-state" {
  name           = "terraform-state"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

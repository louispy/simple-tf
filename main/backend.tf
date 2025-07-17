# terraform {
#   backend "s3" {
#     bucket         = "my-terraform-bucket-233384af-6a1e-4efc-aa88-3643f91ac455"
#     key            = "env/dev/terraform.tfstate"
#     region         = "ap-southeast-3"
#     dynamodb_table = "terraform-lock-table"
#     encrypt        = true
#   }
# }

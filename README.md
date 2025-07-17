# Setup

1. make main.tf file
2. put in region name, ami (find in ec2 instances -> launch instance) and instance type i.e t2.micro, t3.micro
3. `terraform init` to Set up Terraform in this folder
4. `terraform plan` to Show what it will do
5. `terraform apply` to Actually launch the EC2 instance (type 'yes' to confirm)
6. `terraform destroy` to destroy


# To use s3 + dynamodb versioning

## Delete S3

```
aws s3 rm s3://your-tf-state-bucket --recursive
aws s3 rb s3://your-tf-state-bucket --force
```

## Delete DynamoDB

```
aws dynamodb delete-table --table-name terraform-lock
```

## Clean up tf state

### TL;DR
Delete the infra resources with `terraform destroy`
Empty the S3 buckets: delete all versions of the objects
Toggle the `Show versions` toggle button, check all the objects in the shown buckets
Delete the bootstrap resources (S3 + dynamodb) with `terraform destroy`

To safely delete your S3 bucket and DynamoDB table (used for Terraform remote state) before your 12-month AWS Free Tier ends, follow this step-by-step checklist:

🧹 Step 1: Clean up your infrastructure
Before deleting the backend, destroy any infrastructure that uses the S3/DynamoDB remote backend:

```
terraform destroy
```

🧯 Step 2: Disable the remote backend temporarily
If you're using a backend "s3" block in your main.tf or backend.tf, Terraform won't let you delete the backend resources while still using them. So you need to:

🛑 Temporarily switch to local backend:
Comment out or remove this block:

hcl
Copy
Edit
terraform {
  backend "s3" {
    bucket         = "your-tf-state-bucket"
    key            = "global/s3/terraform.tfstate"
    region         = "ap-southeast-3"
    dynamodb_table = "terraform-lock"
  }
}
Then reinitialize:

bash
Copy
Edit
terraform init -migrate-state
This will move the state back to local (creates terraform.tfstate locally).

🗑 Step 3: Delete the S3 bucket
If you enabled force_destroy = true in your Terraform code:

hcl
Copy
Edit
resource "aws_s3_bucket" "tf_state" {
  bucket = "your-tf-state-bucket"
  force_destroy = true
}
You can just run:

```
terraform destroy
```

If not, delete it manually:

Option A: AWS CLI

```
aws s3 rm s3://your-tf-state-bucket --recursive
aws s3 rb s3://your-tf-state-bucket --force
```

Option B: AWS Console
Go to S3 > your bucket

Empty the bucket

Then click Delete bucket

🗑 Step 4: Delete the DynamoDB Table
AWS CLI:

```
aws dynamodb delete-table --table-name terraform-lock
```

Or AWS Console:
Go to DynamoDB > Tables

Select your terraform-lock table

Choose Actions > Delete table

✅ Final Check
Make sure the state file is now local (terraform.tfstate)

Make sure all infra is destroyed

Make sure no S3 bucket or DynamoDB table remains

Nothing left = Nothing to charge for




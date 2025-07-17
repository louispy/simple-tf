# Setup

1. make main.tf file
2. put in region name, ami (find in ec2 instances -> launch instance) and instance type i.e t2.micro, t3.micro
3. `terraform init` to Set up Terraform in this folder
4. `terraform plan` to Show what it will do
5. `terraform apply` to Actually launch the EC2 instance (type 'yes' to confirm)
6. `terraform destroy` to destroy


# To use S3 + DynamoDB Versioning

Go to `terraform-bootstrap` folder and run
```
terraform init
terraform plan
terraform apply
```

This creates an S3 bucket (+ .tfstate file) with versioning enabled and a DynamoDB lock table.

Go back to the `main` folder.
In main/backend.tf uncomment the backend setup code then run
```
terraform init
terraform plan
terraform apply
```

## Clean up tf state

### TL;DR
Delete the infra resources with `terraform destroy`
Empty the S3 buckets: delete all versions of the objects
Tips: toggle the `Show versions` toggle button, check all the objects in the shown buckets
Delete the bootstrap resources (S3 + dynamodb) with `terraform destroy`

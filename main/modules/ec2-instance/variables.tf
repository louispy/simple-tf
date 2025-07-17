variable "ami" {
  description = "AMI ID for the instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Key pair to use for SSH"
  type        = string
}

variable "name" {
  description = "Name tag for the instance"
  type        = string
}

variable "security_group_ids" {
  description = "Security group ids"
  type        = list(string)
}

variable "subnet_id" {
  description = "Subnet ID for instance"
  type        = string
}

variable "private_key_path" {
  description = "Path to private key"
  type        = string
}

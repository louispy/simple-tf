variable "name" {
  description = "VPC Name"
  type        = string
}


variable "vpc_cidr" {
  description = "CIDR"
  type        = string
}

variable "public_subnet_cidr" {
  description = "public_subnet_cidr"
  type        = string

}

variable "availability_zone" {
  description = "Availability Zone"
  type        = string
}

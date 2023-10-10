variable "aws-key-pair" {
  description = "key pair to be use"
  type        = string
  default     = "terraform-cicd"
}

variable "iam_instance_profile" {
  description = "The name of the IAM instance profile"
  type        = string
  default     = "deploy-docker-ec2"
}

variable "instance_type" {
  description = "My instance type"
  type        = string
  default     = "t2.micro"
}

variable "region" {
  description = "Region to be used"
  type        = string
  default     = "us-east-1"
}

variable "aws-key-pair" {
  type    = string
  default = "terraform"
}

data "template_file" "user_data" {
  template = file("./userdata.yml")
}

# Create ec2_instance
resource "aws_instance" "sample-web-app" {
  ami           = "ami-051f7e7f6c2f40dc1"
  iam_instance_profile = "deploy-docker-ec2"
  instance_type = "t2.micro"
  key_name     = var.aws-key-pair
  vpc_security_group_ids = []
  tags = {
    Name : "Ec2_instance"
  }
  user_data = data.template_file.user_data.rendered
}



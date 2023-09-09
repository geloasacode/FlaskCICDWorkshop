data "template_file" "user_data" {
  template = file("./userdata.yml")
}

# Create ec2_instance
resource "aws_instance" "sample-web-app" {
  ami                    = "ami-051f7e7f6c2f40dc1"
  iam_instance_profile   = var.iam_instance_profile
  instance_type          = var.instance_type
  key_name               = var.aws-key-pair
  vpc_security_group_ids = []
  tags = {
    Name : "Ec2_instance"
  }
  user_data = data.template_file.user_data.rendered
}



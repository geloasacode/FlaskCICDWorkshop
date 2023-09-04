# Create IAM policy
resource "aws_iam_role_policy" "policy_ec2" {
  name = "policy_for_ec2"
  role = aws_iam_role.AWS-Docker-Image.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetAuthorizationToken",
          "ecr:BatchGetImage",
          "ec2:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

# Create IAM role
resource "aws_iam_role" "AWS-Docker-Image" {
  name = "AWS-Docker-Image"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# Create instance profile using role
resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = aws_iam_role.AWS-Docker-Image.name
}

# Create ec2_instance
resource "aws_instance" "sample-web-app" {
  ami                  = "ami-051f7e7f6c2f40dc1"
  iam_instance_profile = aws_iam_instance_profile.test_profile.name
  instance_type        = "t2.micro"
  key_name             = "terraform"
  tags = {
    Name : "Sample-web"
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("./terraform.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install jq",
      "sudo yum install docker -y",
      "sudo service docker start",
      "sudo usermod -aG docker ec2-user",
      "exit", # Log out from ec2-user
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 608569176201.dkr.ecr.us-east-1.amazonaws.com",
      # Query image tags and store them in a variable     
      "image_tags=$(aws ecr describe-images --repository-name gero --output json --query 'imageDetails[].imageTags[]' | jq -r 'join(" ")')",  
      # Get the latest image tag       
      "latest_tag=$(echo $image_tags | tr ' ' '\n' | sort -V | tail -n 1)",     
      "docker pull 608569176201.dkr.ecr.us-east-1.amazonaws.com/gero:${latest_tag}",
      "docker run -d -p 8080:8080 608569176201.dkr.ecr.us-east-1.amazonaws.com/gero:${latest_tag}"
    ]
  }
}
# Dockerized Simple Flask Application Deployed in Amazon ECR

This repository contains a Python web application that has been dockerized and uploaded to Amazon Elastic Container Registry (ECR). The application can be pulled from ECR and run on any compatible machine, such as an Amazon EC2 instance.

## Application Overview

The Python web application is built using Flask and displays a colored background. The color can be specified using command-line arguments or environment variables. The application provides several routes to retrieve color, version information, and more.

## Steps Taken

1. **Creating the Python App:**
   The Python web application was created using Flask and includes logic to display a colored background and handle different color options.

2. **Dockerization:**
   The application was dockerized by creating a Dockerfile. The Dockerfile specifies the base image, copies the application code into the container, and configures the application's dependencies and settings.

3. **Uploading to Amazon ECR:**
   The dockerized image was uploaded to Amazon ECR, a fully managed Docker container registry. This step involved creating an ECR repository, authenticating Docker with the ECR registry, and pushing the image to the repository.

4. **Running on EC2 or Any Compatible Machine:**
   Once the image is in the ECR repository, it can be pulled and run on any compatible machine. For example, you can run the application on an Amazon EC2 instance by pulling the image from the ECR repository and starting a Docker container.

## Prerequisites

- [Docker](https://www.docker.com/get-started) installed on your local machine or target machine.
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate AWS credentials and region.

## Steps to Run the Application

1. **Pull the Image from ECR:**
   Run the following command to authenticate Docker with your ECR registry and pull the docker image:

   ```bash
   aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 608569176201.dkr.ecr.us-east-1.amazonaws.com
   docker pull 608569176201.dkr.ecr.us-east-1.amazonaws.com/simple-flask:1.0
   ```

2. **Run the Docker Container:**
   Run the pulled image in a Docker container. Make sure to map the container port to a host port if necessary. Replace `<your-ec2-public-ip>` with the actual public IP or DNS of your EC2 instance.

   ```bash
   docker run -d -p 8080:8080 608569176201.dkr.ecr.us-east-1.amazonaws.com/simple-flask:1.0
   ```

3. **Access the Application:**
   You may now access it by opening a web browser and navigating to:

   ```
   http://<your-ec2-public-ip>:8080
   ```

## Notes

- This is a simplified example for educational purposes.
- Ensure proper security group settings to allow traffic on the required ports.
- AWS credentials and permissions must be configured correctly for ECR access.
- Remember to clean up resources when they are no longer needed.

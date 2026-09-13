# TaskFlow DevOps Project

A hands-on DevOps project demonstrating a complete workflow from a Flask application to containerization and cloud infrastructure on AWS.

## Architecture

Flask Application
        |
        v
      Docker
        |
        v
   Amazon ECR
        |
        v
 Kubernetes / Amazon EKS
        |
        v
 AWS Load Balancer
        |
        v
     Internet

## Technologies

- Python
- Flask
- Docker
- Amazon ECR
- Kubernetes
- Amazon EKS
- Terraform
- AWS VPC
- AWS EC2
- AWS IAM
- AWS Load Balancer

## Project Structure

taskflows-devops/
|
├── flask-app/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
|
├── terraform/
│   ├── versions.tf
│   ├── provider.tf
│   ├── variables.tf
│   ├── main.tf
│   ├── vpc.tf
│   ├── security_groups.tf
│   ├── ec2.tf
│   ├── iam.tf
│   ├── eks.tf
│   ├── ecr.tf
│   └── outputs.tf
|
├── deployment.yaml
├── service.yaml
├── .gitignore
└── README.md

## Flask Application

The application is a simple Flask web application with two endpoints:

- / - Application status
- /health - Health check

Example response:

TaskFlow DevOps App is running!

Health check:

OK

## Docker

Build the Docker image:

    docker build -t taskflow-app:latest ./flask-app

Run the application locally:

    docker run -p 5000:5000 taskflow-app:latest

The application runs on:

    http://localhost:5000

## Amazon ECR

The Docker image is stored in Amazon Elastic Container Registry (ECR).

ECR Repository:

    <ECR_REGISTRY>/taskflow

Login to ECR:

    aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin <ECR_REGISTRY>

Tag the image:

    docker tag taskflow-app:latest <ECR_REGISTRY>/taskflow:latest

Push the image:

    docker push <ECR_REGISTRY>/taskflow:latest

## Kubernetes

The project contains Kubernetes Deployment and Service manifests.

The Deployment runs multiple replicas of the Flask application.

Apply the Deployment:

    kubectl apply -f deployment.yaml

Apply the Service:

    kubectl apply -f service.yaml

Check Pods:

    kubectl get pods

Check Service:

    kubectl get svc

The Kubernetes Service is configured as a LoadBalancer and forwards traffic from port 80 to the Flask application on port 5000.

## Terraform

Terraform is used to define AWS infrastructure as code.

The Terraform configuration includes:

- VPC
- Public subnets
- Private subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- IAM Roles
- EC2
- EKS
- ECR

Initialize Terraform:

    terraform init

Validate the configuration:

    terraform validate

Review infrastructure changes:

    terraform plan

Apply infrastructure:

    terraform apply

## AWS Region

    eu-north-1

## Security

Sensitive Terraform files and local configuration files are excluded using .gitignore.

The following files should never be committed to GitHub:

    terraform.tfstate
    terraform.tfstate.backup
    terraform.tfvars
    .terraform/
    .DS_Store

## Project Goal

The goal of this project is to practice a real-world DevOps workflow:

Application
     ↓
Docker
     ↓
Amazon ECR
     ↓
Kubernetes
     ↓
Amazon EKS
     ↓
AWS Load Balancer

This project demonstrates practical experience with containerization, cloud infrastructure, Infrastructure as Code, container registries, and Kubernetes deployment.

## Author

Mostafa

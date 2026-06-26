# Project Bedrock Capstone – AWS Retail Store Sample Application

> **AltSchool Africa – School of Engineering (Cloud Engineering) Capstone Project**

---

# Student Information

**Student Name:** Otobong Emmanuel Sunday

**Student ID:** ALT/SOE/025/4655

**Project Name:** Project Bedrock

**AWS Region:** us-east-1 (N. Virginia)

**Deployment Date:** June 2026

---

# Project Overview

Project Bedrock is a production-style deployment of the AWS Retail Store Sample Application using Infrastructure as Code (Terraform) on Amazon Web Services.

The project provisions a complete cloud-native environment consisting of:

* Amazon EKS Cluster
* Custom VPC
* Amazon RDS (MySQL & PostgreSQL)
* Amazon ElastiCache Redis
* Amazon DynamoDB
* Amazon OpenSearch
* Amazon S3
* AWS Lambda
* AWS Load Balancer Controller
* Kubernetes
* Helm
* CloudWatch Logging

The objective of the project was to demonstrate the ability to provision, deploy, troubleshoot, and manage cloud infrastructure using Terraform while following AWS best practices.

---

# Architecture

```
                    Internet
                        │
                        ▼
             Network Load Balancer
                        │
                        ▼
               Amazon EKS Cluster
          project-bedrock-cluster
                        │
 ┌──────────────┬──────────────┬──────────────┬──────────────┐
 ▼              ▼              ▼              ▼              ▼
UI           Catalog        Orders        Checkout        Carts
 │               │              │              │              │
 ▼               ▼              ▼              ▼              ▼
OpenSearch     MySQL       PostgreSQL       Redis       DynamoDB
                        │
                        ▼
                  Amazon S3 Assets
                        │
                        ▼
                     AWS Lambda
                        │
                        ▼
                  Amazon CloudWatch
```

---

# Technologies Used

## Infrastructure

* Terraform
* AWS CLI
* Git
* GitHub

## AWS Services

* Amazon EKS
* Amazon EC2
* Amazon VPC
* Amazon IAM
* Amazon RDS
* Amazon DynamoDB
* Amazon OpenSearch
* Amazon ElastiCache Redis
* Amazon S3
* AWS Lambda
* CloudWatch
* Elastic Load Balancer

## Kubernetes

* Kubernetes
* Helm
* AWS Load Balancer Controller
* kubectl

---

# Infrastructure Provisioned

## Amazon EKS

| Property           | Value                   |
| ------------------ | ----------------------- |
| Cluster Name       | project-bedrock-cluster |
| Region             | us-east-1               |
| Kubernetes Version | 1.34                    |
| Worker Nodes       | 3                       |
| Deployment         | Terraform               |

---

## Networking

Resources provisioned:

* Custom VPC
* Public Subnets
* Private Subnets
* Internet Gateway
* NAT Gateway
* Route Tables
* Security Groups

All networking resources are managed entirely through Terraform.

---

## Databases

### Catalog Database

Engine:

* MySQL 8

Purpose:

* Product catalog

---

### Orders Database

Engine:

* PostgreSQL

Purpose:

* Customer orders

---

### Other Data Stores

* DynamoDB
* ElastiCache Redis
* Amazon OpenSearch

---

# Kubernetes Workloads

Successfully deployed microservices:

* UI
* Catalog
* Orders
* Checkout
* Carts

Additional supporting services:

* AWS Load Balancer Controller
* cert-manager
* OpenTelemetry Operator

All pods reached **Running** state.

---

# Public Application

Application URL

```
http://k8s-ui-ui-519a3d99b3-9294fd8c5a474400.elb.us-east-1.amazonaws.com
```

---

# Assets Bucket

Bucket Name

```
bedrock-assets-1-alt-soe-025-4655
```

Configuration:

* Private Bucket
* Versioning Enabled
* Public Access Blocked
* Lambda Notification Enabled

---

# Lambda Integration

Function Name

```
bedrock-asset-processor
```

Trigger

* Amazon S3 ObjectCreated Event

Purpose

* Process uploaded assets
* Log upload events to CloudWatch

---

# IAM

Developer User

```
bedrock-dev-view
```

Policy

* Upload access to project assets bucket

---

# Terraform Outputs

The root module exposes the following outputs:

* cluster_name
* cluster_endpoint
* region
* vpc_id
* assets_bucket_name
* retail_app_url

---

# Resource Tagging

All infrastructure resources are tagged using:

```
Project = karatu-2025-capstone
```

Additional tags include:

* created-by
* environment-name

---

# Repository Structure

```
terraform/
    eks/
        default/

lib/

src/

helm/

values/

README.md
grading.json
```

---

# Deployment Steps

1. Clone repository

```
git clone <repository-url>
```

2. Navigate to Terraform configuration

```
cd terraform/eks/default
```

3. Initialize Terraform

```
terraform init
```

4. Review infrastructure

```
terraform plan
```

5. Deploy infrastructure

```
terraform apply
```

6. Configure kubectl

```
aws eks update-kubeconfig \
--region us-east-1 \
--name project-bedrock-cluster
```

7. Verify cluster

```
kubectl get nodes
kubectl get pods -A
```

8. Retrieve application URL

```
kubectl get svc -n ui
```

---

# Challenges Encountered

## RDS Connectivity

Problem

Pods could not connect to MySQL and PostgreSQL.

Resolution

Updated Terraform security group rules to reference the EKS worker node security group.

---

## OpenSearch

Problem

OpenSearch domain creation initially failed because the required service-linked role was unavailable.

Resolution

Verified the AWS service-linked role and re-ran Terraform successfully.

---

## Load Balancer

Problem

The UI service remained in the Pending state.

Resolution

Corrected subnet tagging and validated the AWS Load Balancer Controller configuration. The Network Load Balancer was successfully provisioned.

---

## Helm Deployment

Problem

The UI Helm release entered a failed state due to provisioning timeouts.

Resolution

Re-applied the Helm release after the infrastructure stabilized.

---

## Lambda

Problem

Initial testing produced a KeyError because the Lambda function was manually invoked without an S3 event payload.

Resolution

Verified bucket notifications, Lambda permissions, and CloudWatch log group creation. S3 event integration was successfully configured.

---

# Validation

The following checks were completed successfully:

✅ Terraform Apply

✅ Amazon EKS Cluster Active

✅ Worker Nodes Ready

✅ All Kubernetes Pods Running

✅ Load Balancer Provisioned

✅ Public Application Accessible

✅ MySQL Operational

✅ PostgreSQL Operational

✅ OpenSearch Operational

✅ Redis Operational

✅ DynamoDB Operational

✅ Assets Bucket Created

✅ Lambda Function Created

✅ CloudWatch Log Group Created

✅ Terraform Outputs Generated

---

# Skills Demonstrated

* Infrastructure as Code (Terraform)
* Amazon Web Services
* Amazon EKS
* Kubernetes Administration
* Helm Deployments
* Cloud Networking
* IAM
* Security Groups
* Amazon RDS
* Amazon OpenSearch
* Amazon S3
* AWS Lambda
* CloudWatch
* Troubleshooting Production Infrastructure
* Git Version Control

---

# Screenshots

Include screenshots of:

* AWS Console Dashboard
* Terraform Apply
* EKS Cluster
* EC2 Worker Nodes
* Kubernetes Pods
* RDS Databases
* OpenSearch
* DynamoDB
* Redis
* S3 Bucket
* Lambda Function
* CloudWatch Logs
* Load Balancer
* Running Retail Store Application

---

# Conclusion

This capstone project demonstrates the successful deployment of a production-style cloud-native retail application on AWS using Terraform and Kubernetes. The infrastructure includes networking, compute, managed databases, storage, search, caching, identity management, serverless integration, monitoring, and load balancing, showcasing end-to-end cloud engineering skills and operational troubleshooting throughout the deployment lifecycle.

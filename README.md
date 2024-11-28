# AWS Environment Management with Terraform and GitHub Actions

## Overview

This repository is a project designed to manage an AWS environment using **Terraform** and automate deployment through **GitHub Actions**. It provisions and manages AWS resources, including **AWS Lambda**, **S3 Bucket**, **IAM Role**, and **CloudWatch Logs**, while handling environment-specific deployments (e.g., production and development).

The core functionality involves using an AWS Lambda function (written in Python with **boto3**) to process text files in an S3 bucket. The Lambda function reverses the string contents of uploaded `.txt` files and saves the processed files back to the same S3 bucket under a specific prefix.

## Features

- **AWS Resource Management**: Automates the creation and configuration of AWS resources using Terraform.
- **S3 Event Notification**: Triggers the Lambda function whenever a `.txt` file is uploaded.
- **Lambda String Processing**: Reverses the string content of the file and uploads the updated version.
- **CloudWatch Logging**: Monitors Lambda execution and logs for troubleshooting and auditing.
- **GitHub Actions CI/CD**: Automates the deployment process to different environments based on branch-specific triggers.

## Project Structure

### AWS Resources

1. **S3 Bucket**:
   - Stores `.txt` files with the original and reversed content.
   - S3 Prefix for original content is defined as `input_prefix` in the terraform module
   - S3 Prefix for reversed content is defined as `output_prefix` in the terraform module
   - Configured with event notifications to trigger the Lambda function.
2. **AWS Lambda**:
   - Written in Python using **boto3**.
   - Processes `.txt` files, reverses their content, and uploads them back to S3.
3. **IAM Role**:
   - Grants the Lambda function permissions to access S3, CloudWatch, and other necessary resources.
4. **CloudWatch Logs**:
   - Captures logs for the Lambda function's execution and provides visibility into processing.

### CI/CD Workflow

- **GitHub Actions**:
  - Deploys Terraform configurations to the desired AWS environment (e.g., `production` or `development`) based on branch-specific workflows.
  - Automatically builds and deploys updates to the infrastructure.
  - GitHub Environment stored the necessary environment variables

## How It Works

### S3 and Lambda Workflow

1. A `.txt` file containing string data is uploaded to the S3 bucket.
2. The S3 event notification triggers the Lambda function.
3. The Lambda function:
   - Reads the file content.
   - Reverses the string data.
   - Saves the reversed content into a new `.txt` file with the same name, appended with `_reversed`, under a specified prefix.
4. The updated file is uploaded to the same S3 bucket.

### Deployment Workflow

- **GitHub Actions** automatically deploy Terraform configurations:
  - **Development Environment**: Triggered by a push to the `dev` branch.
  - **Production Environment**: Triggered by a push to the `main` branch.

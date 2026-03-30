# 🚀 Dynamic AWS Infrastructure with Terraform

This repository contains a modular Terraform configuration to deploy an **Amazon EC2 Instance** and a **dynamically named S3 Bucket**. It features a robust OS selection system using Data Sources and input validation.

## 📋 Project Overview

The setup allows a user to choose between three operating systems (**Amazon Linux**, **Ubuntu**, or **RHEL**) at runtime. Terraform then fetches the latest AMI ID automatically and ensures the S3 bucket name remains globally unique using random suffixes.

### 🏗️ Architecture & File Structure

The configuration is split into 6 specialized `.tf` files for better maintainability:

| File | Purpose |
| :--- | :--- |
| `provider.tf` | Configures the AWS Provider. |
| `terraform.tf` | Defines Terraform settings and required provider versions. |
| `data.tf` | 🔍 Contains filters for fetching the latest AMIs (Amazon, Ubuntu, RHEL). |
| `variables.tf` | 📥 Defines input variables, including the OS type with validation logic. |
| `main.tf` | 🛠️ Core logic for creating the EC2 instance and the unique S3 bucket. |
| `outputs.tf` | 📤 Displays the Public IP of the EC2 and the generated S3 Bucket name. |

---

## ✨ Key Features

* **Dynamic AMI Lookup**: Uses `data` blocks to query the latest official images, so you never have to hardcode an AMI ID again.
* **OS Validation**: The `os_type` variable includes a validation block to ensure only `amazon`, `ubuntu`, or `rhel` are entered.
* **Unique S3 Naming**: Implements a naming strategy that prevents "Bucket Name Already Exists" errors.
* **Clean Outputs**: Immediately see your instance's connection details after deployment.

---

## 🚀 Getting Started

### 1. Prerequisites
* [Terraform](https://www.terraform.io/downloads.html) installed (v1.0+)
* AWS CLI configured with appropriate credentials.

### 2. Deployment Steps

1.  **Initialize the directory:**
    ```bash
    terraform init
    ```

2.  **Plan the infrastructure:**
    You will be prompted to enter the `os_type`.
    ```bash
    terraform plan
    ```

3.  **Apply the changes:**
    ```bash
    terraform apply -var="os_type=ubuntu"
    ```

---

## 🛠️ Variables & Configuration

| Name | Description | Default | Valid Options |
| :--- | :--- | :--- | :--- |
| `os_type` | The OS to use for the EC2 instance. | `No Default Value` | `amazon`, `ubuntu`, `rhel` |
| `bucket_name` | The unique name for the S3 bucket. | `Fetched during runtime using locals` | Any string |

> **Note:** If you enter an invalid OS (e.g., "windows"), Terraform will catch it during the plan phase thanks to the validation block in `variables.tf`.

---

## 📊 Outputs

Upon successful completion, Terraform will output:
* `ec2_public_ip`: The address used to SSH into your instance.
* `ec2_public_dns`: The DNS Name of your EC2 instance.
* `s3_bucket_name`: The full, unique name of your created bucket.

---

## 🤝 Contributing
Feel free to open an issue or submit a pull request if you want to add more OS flavors or security group configurations!

⭐ **If you found this helpful, please give this repo a star!**
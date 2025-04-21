# AWS Terraform Project

This project deploys a simple web application on AWS using Terraform/OpenTofu. It creates a VPC, two subnets, EC2 instances, and a load balancer to distribute traffic.

## Setup Instructions

### 1. AWS Credentials Setup

First, create the credentials file:

```
mkdir -p ~/.aws
```

Add your AWS Academy credentials to `~/.aws/credentials`:
```
[default]
aws_access_key_id=YOUR_ACCESS_KEY
aws_secret_access_key=YOUR_SECRET_KEY
aws_session_token=YOUR_SESSION_TOKEN
```

### 2. SSH Key Setup

1. Create a `.ssh` directory in your project folder:
   ```
   mkdir -p .ssh
   ```

2. Download `labsuser.pem` from the "AWS Details" button in your Vocareum lab page

3. Save the file to your project's `.ssh` directory

4. Generate the public key:
   ```
   cd .ssh
   ssh-keygen -y -f labsuser.pem > labsuser.pub
   cd ..
   ```

> **Important:** You need to update these files EVERY TIME you start a new lab session, as new credentials are generated each time.

### 3. Running Terraform

```
terraform init
terraform plan
terraform apply
```

Or if using OpenTofu:

```
tofu init
tofu plan
tofu apply
```

### 4. Accessing the Application

After successful deployment, you'll see the load balancer DNS name in the outputs. 
Access it using `http://` (not `https://`).

### 5. Cleaning Up

Always destroy your resources before ending your lab session:

```
terraform destroy
```

or 

```
tofu destroy
```

## Files in this Project

- `main.tf` - Main infrastructure code
- `variables.tf` - Variable definitions
- `providers.tf` - AWS provider configuration
- `user_data.sh` - Startup script for EC2 instances
- `.ssh/` - Directory for SSH keys (not included in repository)

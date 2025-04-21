terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>4.16"
    }
  }
}

provider "aws" {
  region    = var.region
  shared_credentials_files = [
    # Mac users uncomment this line:
    "~/.aws/credentials"
    # Windows users uncomment this line:
    # "%USERPROFILE%\\.aws\\credentials"
  ]
  profile   = "default"
}

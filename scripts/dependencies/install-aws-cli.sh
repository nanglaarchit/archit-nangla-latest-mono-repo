#!/bin/bash

# Check and install AWS CLI if not present
if ! command -v aws &> /dev/null; then
  cd /tmp
  # curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
  curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "/tmp/awscliv2.zip"
  unzip /tmp/awscliv2.zip
  /tmp/aws/install
else
  printf "AWS CLI already exists...\n"
  :
fi

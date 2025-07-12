#!/bin/bash

echo "Starting AWS deployment..."

aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"
aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
aws configure set default.region "$AWS_REGION"

# Example: Deploy static site to S3
aws s3 sync ./public s3://$AWS_DEPLOY_BUCKET --delete

echo "Deployment to AWS completed ✅"

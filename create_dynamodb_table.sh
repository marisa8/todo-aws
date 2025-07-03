#!/bin/bash

# -----------------------------
# AWS CLI Script to create DynamoDB Todos Table
# Author: (cicd_handson)
# Date: (2025/07/03)
# -----------------------------

# Variables
TABLE_NAME="Todos"
PROFILE="cicd_handson"
REGION="ap-northeast-1"

echo "Creating DynamoDB table: $TABLE_NAME"

aws dynamodb create-table \
  --table-name $TABLE_NAME \
  --attribute-definitions AttributeName=id,AttributeType=S \
  --key-schema AttributeName=id,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region $REGION \
  --profile $PROFILE

echo "Table creation command issued. Use describe-table to check status:"
echo "aws dynamodb describe-table --table-name $TABLE_NAME --region $REGION --profile $PROFILE"

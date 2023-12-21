#!/bin/bash

# AWS CLI ile tüm bölgelerin listesini alın
regions=$(aws ec2 describe-regions --query "Regions[].RegionName" --output text --profile linga)

# CloudWatch Logs için teslim izni IAM rolünü oluşturun veya alın
role_name="FlowLogDeliveryRole"

role_arn=$(aws iam get-role --role-name "$role_name" --query "Role.Arn" --output text --profile linga)

if [ -z "$role_arn" ]; then
  echo "IAM rolü oluşturuluyor..."
  role_arn=$(aws iam create-role --role-name "$role_name" --assume-role-policy-document '{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Principal":{"Service":"vpc-flow-logs.amazonaws.com"},"Action":"sts:AssumeRole"}]}' --query "Role.Arn" --output text --profile linga)
  echo "IAM rolü oluşturuldu. ARN: $role_arn"
else
  echo "IAM rolü zaten var. ARN: $role_arn"
fi

# CloudWatch Logs için teslim izni IAM rolüne izinleri ata
policy_document='{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Effect":"Allow",
      "Action":"logs:CreateLogStream",
      "Resource":"arn:aws:logs:'$region':'$account_id':log-group:VPC-Flow-Logs:log-stream:FlowLogStream",
      "Condition":{
        "StringEquals":{
          "aws:RequestTag/deliveryStream":"FlowLogStream"
        }
      }
    },
    {
      "Effect":"Allow",
      "Action":"logs:PutLogEvents",
      "Resource":"arn:aws:logs:'$region':'$account_id':log-group:VPC-Flow-Logs:log-stream:FlowLogStream"
    }
  ]
}'

aws iam put-role-policy --role-name "$role_name" --policy-name FlowLogDeliveryPolicy --policy-document "$policy_document" --profile linga

echo "IAM rolüne izinler atanmıştır."

# Her bir bölge için VPC'leri listeleyin ve VPC Flow Log'u etkinleştirin
for region in $regions; do
  echo "Bölge: $region"

  # Varsayılan VPC'leri listeleyin
  default_vpcs=$(aws ec2 describe-vpcs --filters "Name=isDefault,Values=true" --query "Vpcs[].VpcId" --output text --region $region --profile linga)

  # Her bir varsayılan VPC için VPC Flow Log'u etkinleştirin
  for vpc_id in $default_vpcs; do
    echo "VPC ID: $vpc_id"

    # VPC Flow Log'u oluşturma
    flow_log_id=$(aws ec2 create-flow-logs --resource-type VPC --resource-id $vpc_id --traffic-type ALL --log-destination-type cloud-watch-logs --log-group-name "VPC-Flow-Logs" --deliver-logs-permission-arn $role_arn --region $region --query "FlowLogIds[0]" --output text --profile linga)

    echo "VPC Flow Log oluşturuldu. Flow Log ID: $flow_log_id"
    echo "-------------------------------------------------------"
  done
done


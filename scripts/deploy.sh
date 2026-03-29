#!/bin/bash
ENV=$1
if [ -z "$ENV" ]; then
  echo "Usage: ./deploy.sh [dev|uat|prod]"
  exit 1
fi

terraform workspace select $ENV || terraform workspace new $ENV
terraform apply -var-file=$ENV.tfvars -auto-approve
func azure functionapp publish ${ENV}-ingest-func --python
powershell ./powerbi/scripts/refresh_dashboards.ps1
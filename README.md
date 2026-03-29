# dominolabs-adx-auditlogs

├─ terraform/
│  ├─ main.tf                   # Root orchestration
│  ├─ variables.tf
│  ├─ outputs.tf
│  ├─ dev.tfvars
│  ├─ uat.tfvars
│  ├─ prod.tfvars
│  └─ modules/
│      ├─ blob/
│      │   ├─ main.tf
│      │   └─ README.md
│      ├─ adx/
│      │   ├─ main.tf
│      │   └─ README.md
│      └─ function/
│          ├─ main.tf
│          └─ README.md
├─ functions/
│  ├─ ingest_logs/
│  │   ├─ run.py                # ingestion logic
│  │   └─ function.json
│  └─ utils/
│      └─ helpers.py
├─ powerbi/
│  ├─ dashboards/
│  │   ├─ DevAudit.pbix         # placeholder
│  │   ├─ UATAudit.pbix         # placeholder
│  │   └─ ProdAudit.pbix        # placeholder
│  ├─ queries/
│  │   ├─ hot_adx_queries.pq    # placeholder
│  │   └─ archive_adx_queries.pq
│  └─ scripts/
│      └─ refresh_dashboards.ps1
├─ pipelines/
│  └─ azure-pipelines.yml
├─ scripts/
│  └─ deploy.sh
└─ README.md

# Domino Audit Platform

This repository contains a production-ready setup to ingest Domino lab audit logs into **Azure Data Explorer**, archive logs in **Azure Blob Storage**, and visualize via **Power BI**.

## Features

- Hot ADX table for recent logs (90 days)
- Archive storage for 30 years
- Azure Function for ingestion from 2 blob containers
- Dev / UAT / Prod environment separation
- Power BI dashboards per environment
- CI/CD pipeline via Azure DevOps

## Deployment

```bash
./scripts/deploy.sh dev
./scripts/deploy.sh uat
./scripts/deploy.sh prod

| Name                    | Value / Description                               | Secret? |
| ----------------------- | ------------------------------------------------- | ------- |
| `AZURE_SUBSCRIPTION_ID` | `<your-subscription-id>`                          | ✅       |
| `AZURE_TENANT_ID`       | `<your-tenant-id>`                                | ✅       |
| `AZURE_CLIENT_ID`       | `<service-principal-client-id>`                   | ✅       |
| `AZURE_CLIENT_SECRET`   | `<service-principal-client-secret>`               | ✅       |
| `AZURE_RESOURCE_GROUP`  | `domino-logs-dev-rg`                              | ❌       |
| `AZURE_LOCATION`        | `eastus`                                          | ❌       |
| `STORAGE_ACCOUNT_KEY`   | `<dev-storage-account-key>`                       | ✅       |
| `APP_SERVICE_PLAN_ID`   | `<dev-app-service-plan-id>`                       | ❌       |
| `ADX_CLUSTER_URL`       | `https://dev-adxcluster.eastus.kusto.windows.net` | ❌       |
| `ADX_DB_NAME`           | `dev_auditlogs`                                   | ❌       |
| `POWERBI_CLIENT_ID`     | `<powerbi-sp-client-id>`                          | ✅       |
| `POWERBI_CLIENT_SECRET` | `<powerbi-sp-client-secret>`                      | ✅       |
| `POWERBI_TENANT_ID`     | `<powerbi-tenant-id>`                             | ✅       |
| `POWERBI_WORKSPACE`     | `Dev`                                             | ❌       |

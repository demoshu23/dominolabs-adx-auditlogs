import os
import json
from azure.storage.blob import BlobServiceClient
from azure.kusto.data import KustoClient, KustoConnectionStringBuilder
from utils.helpers import normalize_log

STORAGE_CONN = os.environ['AZURE_STORAGE_CONNECTION_STRING']
ADX_CLUSTER = os.environ['ADX_CLUSTER']
ADX_DB = os.environ['ADX_DB']

blob_service = BlobServiceClient.from_connection_string(STORAGE_CONN)
containers = ["container1", "container2"]

kcsb = KustoConnectionStringBuilder.with_aad_device_authentication(ADX_CLUSTER)
client = KustoClient(kcsb)

for container_name in containers:
    container_client = blob_service.get_container_client(container_name)
    for blob in container_client.list_blobs():
        blob_data = container_client.download_blob(blob.name).readall()
        logs = json.loads(blob_data)
        for log in logs:
            row = normalize_log(log)
            client.execute(ADX_DB, f".ingest inline into table AuditLogs <| {json.dumps(row)}")
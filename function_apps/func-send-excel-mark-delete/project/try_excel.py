import pandas as pd
from azure.storage.blob import BlobServiceClient
import os
import logging

def create(connection_string,data):

    # Create a DataFrame
    df = pd.DataFrame(data)

    # Customize the export settings
    custom_header = ['Storage Account', 'Alert Body','Subscription Name','Subscription Manager Email']
    print(df)
    df.to_excel('alert_file.xlsx', index=False, header=custom_header)
    # df.to_excel('output.xlsx', index=False, na_rep='N/A', header=custom_header, index_label='ID')
    logging.warn("!!!")
    container_name = 'excel'
    blob_name = 'alert_file.xlsx'
    # blob_service_client = BlobServiceClient.from_connection_string(connection_string)
    # blob_client = blob_service_client.get_blob_client(container=container_name, blob=blob_name)
    # blob_client.upload_blob(df.to_excel('alert_file.xlsx', index=False, header=custom_header), overwrite=True)
    upload_blob_file(connection_string,container_name)

# def upload_blob_transfer_options(connection_string, container_name, blob_name):
#     blob_service_client = BlobServiceClient.from_connection_string(connection_string)
#     blob_client = blob_service_client.get_blob_client(container=container_name, blob=blob_name)

#     with open(file=os.path.join(r'file_path', blob_name), mode="rb") as data:
#         blob_client = blob_client.upload_blob(data=data, overwrite=True, max_concurrency=2)

def upload_blob_file(connection_string, container_name):
    logging.warn("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    blob_service_client = BlobServiceClient.from_connection_string(connection_string)
    container_client = blob_service_client.get_container_client(container=container_name)
    with open(file=os.path.join('./', 'alert_file.xlsx'), mode="rb") as data:
        blob_client = container_client.upload_blob(name="alert_file.xlsx", data=data, overwrite=True)
        logging.warn(f'blob client: {blob_client}')
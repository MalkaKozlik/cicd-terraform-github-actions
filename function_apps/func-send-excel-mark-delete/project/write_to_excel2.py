from azure.storage.blob import BlobServiceClient
import pandas as pd
import os
import logging

def write_and_upload(connection_string, data):

    df = pd.DataFrame(data)
    custom_header = ['Storage Account', 'Alert Body','Subscription Name','Subscription Manager Email']
    df.to_excel('alert_file.xlsx', index=False, header=custom_header)
    
    upload_blob_file(connection_string)


def upload_blob_file(connection_string):

    blob_service_client = BlobServiceClient.from_connection_string(connection_string)
    container_client = blob_service_client.get_container_client(container='excel')
    with open(file=os.path.join('./', 'alert_file.xlsx'), mode="rb") as data:
        blob_client = container_client.upload_blob(name='alert_file.xlsx', data=data, overwrite=True)
        logging.warn(f'blob client: {blob_client}')

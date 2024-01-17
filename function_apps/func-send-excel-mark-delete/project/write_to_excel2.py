import pandas as pd
from azure.storage.blob import BlobServiceClient
import os
import logging

def write_and_upload(connection_string, data):

    df = pd.DataFrame(data)
    custom_header = ['Storage Account', 'Alert Body','Subscription Name','Subscription Manager Email']
    logging.info(df)
    df.to_excel('alert_file.xlsx', index=False, header=custom_header)
    
    container_name = 'excel'
    blob_name = 'alert_file.xlsx'
    # blob_service_client = BlobServiceClient.from_connection_string(connection_string)
    # blob_client = blob_service_client.get_blob_client(container=container_name, blob=blob_name)
    # blob_client.upload_blob(df.to_excel('alert_file.xlsx', index=False, header=custom_header), overwrite=True)
    upload_blob_file(connection_string,container_name, blob_name)
    # download_blob_to_string(connection_string,container_name)

# def upload_blob_transfer_options(connection_string, container_name, blob_name):
#     blob_service_client = BlobServiceClient.from_connection_string(connection_string)
#     blob_client = blob_service_client.get_blob_client(container=container_name, blob=blob_name)

#     with open(file=os.path.join(r'file_path', blob_name), mode="rb") as data:
#         blob_client = blob_client.upload_blob(data=data, overwrite=True, max_concurrency=2)

def upload_blob_file(connection_string, container_name,blob_name):
    blob_service_client = BlobServiceClient.from_connection_string(connection_string)
    container_client = blob_service_client.get_container_client(container=container_name)
    with open(file=os.path.join('./', blob_name), mode="rb") as data:
        blob_client = container_client.upload_blob(name=blob_name, data=data, overwrite=True)
        logging.warn(f'blob client: {blob_client}')

# def download_blob_to_file(connection_string, container_name):
#     blob_service_client = BlobServiceClient.from_connection_string(connection_string)
#     blob_client = blob_service_client.get_blob_client(container=container_name, blob="alert_file.xlsx")
#     with open(file=os.path.join(r'filepath', 'filename'), mode="wb") as sample_blob:
#         download_stream = blob_client.download_blob()
#         sample_blob.write(download_stream.readall())

# def download_blob_to_string( connection_string, container_name):
#     blob_service_client = BlobServiceClient.from_connection_string(connection_string)
#     blob_client = blob_service_client.get_blob_client(container=container_name, blob="alert_file.xlsx")

#     # encoding param is necessary for readall() to return str, otherwise it returns bytes
#     downloader = blob_client.download_blob(max_concurrency=1, encoding='UTF-8')
#     blob_text = downloader.readall()
#     print(f"Blob contents: {blob_text}")
#     logging.info("[[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]")
#     logging.info(f"Blob contents: {blob_text}")
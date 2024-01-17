import pandas as pd
from azure.storage.blob import BlobServiceClient


def create(connection_string,data):

    # Create a DataFrame
    df = pd.DataFrame(data)

    # Customize the export settings
    custom_header = ['Storage Account', 'Alert Body','Subscription Name','Subscription Manager Email']

    df.to_excel('alert_file.xlsx', index=False, header=custom_header)
    # df.to_excel('output.xlsx', index=False, na_rep='N/A', header=custom_header, index_label='ID')

    # blob_service_client = BlobServiceClient.from_connection_string(connection_string)
    # blob_client = blob_service_client.get_blob_client(container='excel', blob='alert_file.xlsx')
    # blob_client.upload_blob(df.to_excel('alert_file.xlsx', index=False, header=custom_header), overwrite=True)
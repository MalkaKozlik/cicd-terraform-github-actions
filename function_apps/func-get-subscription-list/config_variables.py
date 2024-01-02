from azure.keyvault.secrets import SecretClient
from azure.identity import DefaultAzureCredential
from dotenv import load_dotenv
import os

load_dotenv()

keyvault_uri=os.getenv("KEYVAULT_URI")
secret_name = os.getenv("SECRET")
credential = DefaultAzureCredential()
client = SecretClient(vault_url=keyvault_uri, credential=credential)
connection_string = client.get_secret(secret_name).value

# connection_string = os.getenv("CONNECTION_STRING")

documentation_table=os.getenv("DOCUMENTATION_TABLE")

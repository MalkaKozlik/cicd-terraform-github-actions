import os
from dotenv import load_dotenv

load_dotenv()

connection_string=os.getenv("CONNECTION_STRING")

documentation_table=os.getenv("DOCUMENTATION_TABLE")

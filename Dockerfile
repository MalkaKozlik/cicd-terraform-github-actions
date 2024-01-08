FROM mcr.microsoft.com/azure-functions/python:4-python3.10

ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true \
    AzureWebJobsFeatureFlags=EnableWorkerIndexing \ 
    AzureWebJobsStorage=UseDevelopmentStorage=true \
    Access-Control-Allow-Origin=* \
    Access-Control-Allow-Headers=Content-Type \
    Access-Control-Allow-Methods=GET
    

COPY requirements.txt /
RUN pip install -r /requirements.txt

COPY . /home/site/wwwroot
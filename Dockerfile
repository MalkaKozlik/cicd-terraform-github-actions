FROM mcr.microsoft.com/azure-functions/python:4-python3.10

ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true \
    AzureWebJobsFeatureFlags=EnableWorkerIndexing \ 
    AzureWebJobsStorage=UseDevelopmentStorage=true \
    CORS_ALLOWED_ORIGINS='*'

COPY requirements.txt /
RUN pip install -r /requirements.txt

COPY ./function_apps/func-for-each-subscription /home/site/wwwroot
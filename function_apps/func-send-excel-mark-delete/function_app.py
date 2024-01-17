import azure.functions as func

import logging
# import requests 
# import json
# import os
# import sys
# sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

# # from project.write_to_excel import write_to_excel
# from project.managed_deleted_storages import deleted_storages
# from project.config_variables import *


app = func.FunctionApp()


@app.function_name(name="HttpTrigger1")
@app.route(route="")
def test_function(req: func.HttpRequest) -> func.HttpResponse:

    logging.info('Python HTTP trigger function processed a request.')


    try:
        
        body = req.get_body()
        my_json = body.decode('utf8').replace("'", '"')
        data = json.loads(my_json)
        logging.warn("---------------------")
        # logging.info(data)
        # logging.warn("------------------")
        alerts_to_excel=data["alerts_to_excel"]
        partition_key=data['partition_key']
        all_storages=data['all_storages']

        # result = write_to_excel(excel_connection_string, alerts_to_excel)
        # logging.warn("???????????????!WOW!!!")
        # logging.info(result)
        
        requests.post(
            http_trigger_url,
            json={
                "recipient_email": main_manager,
                "subject": "Summary Alerts For Storage Accounts",
                "body": "summary file",
                "excel":"alert_file.xlsx"
        })
        logging.info("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
        logging.info(requests.status_codes)
        logging.warn("!!!!!!!!!!!!!!!!!!!!!!",requests.status_codes._codes)

        deleted_storages(documentation_table, int(partition_key)-1 , all_storages)

    except Exception as e:
        logging.warn(f"-<<->>-{e}")
        
    return func.HttpResponse("success - end logic app", status_code=200)

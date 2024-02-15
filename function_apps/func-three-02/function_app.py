import azure.functions as func

from project.managed_subscription import *
from config.config_variables import documentation_table


app = func.FunctionApp()

@app.function_name(name="HttpTrigger1")
@app.route(route="")
def func_three_02(req: func.HttpRequest) -> func.HttpResponse:
    subscription_list = get_subscription_list()
    partition_key = str(get_a_last_partitionKey_number(documentation_table) + 1)
    subscriptions=[]
    for subscription in subscription_list:
        subscriptions.append({'subscription_id':subscription.subscription_id,'subscription_name':subscription.display_name})

    answer={'subscriptions':subscriptions,'partition_key':str(partition_key)}

    return func.HttpResponse(str(answer), status_code=200)

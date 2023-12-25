
from read_log_analytics import *


def test_function():

    max_time_foreach_storage = get_array_of_last_fetch_time()

    print(max_time_foreach_storage)

test_function()
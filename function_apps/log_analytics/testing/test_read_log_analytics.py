from unittest.mock import patch, Mock
import pytest
from read_log_analytics import *




class mock_table:
    def __init__(self):
        self.rows = [[0,1],[1,1]]

@patch('read_log_analytics.get_times_logs_per_table', Mock(side_effect = [[1,2],[3,4],[5,6]]))
def test_get_times_logs():
    assert get_times_logs([mock_table(),mock_table(),mock_table()]) == [1,2,3,4,5,6]




@patch("read_log_analytics.DefaultAzureCredential",Mock(return_value="default azure credential"))
@patch("read_log_analytics.LogsQueryClient")
def test_create_log_query_client(LogsQueryClient):
    create_log_query_client()
    LogsQueryClient.assert_called_once_with(
        credential="default azure credential"
    )


def test_return_seconds():
    assert return_seconds({"type_of_time": "days", "number": 10}) == 864000
    assert return_seconds({"type_of_time": "weeks", "number": 2}) == 1209600
    assert return_seconds({"type_of_time": "months", "number": 3}) == 7776000
    assert return_seconds({"type_of_time": "years", "number": 1}) == 31536000
    assert (
        return_seconds({"type_of_time": "f", "number": 1}) == -1
    ), "type date is not valid"


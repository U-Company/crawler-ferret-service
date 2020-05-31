import typing

from clients import http


class Parse(http.Method):
    url_ = "/"
    m_type = "POST"

    def __init__(self, program: str, params: typing.Dict):
        http.Method.__init__(self)
        self.body = {'program': program, 'params': params}


class Version(http.Method):
    url_ = "/health"
    m_type = "GET"


class Get(http.Method):
    url_ = "/version"
    m_type = "GET"

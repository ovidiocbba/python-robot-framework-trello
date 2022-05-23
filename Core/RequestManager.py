import logging

import requests

from Utils import logger
from Utils.meta_classes import Singleton

log = logger.get_logger('dev')


class RequestManager(metaclass=Singleton):

    def __init__(self):
        self.base_url = None
        self.credentials = None
        self.headers = {"Content-Type": "application/json"}
        self.session = requests.Session()

    def set_base_url(self, base_url):
        self.base_url = base_url

    def set_credentials(self, credentials):
        key = credentials['key']
        token = credentials['token']
        self.credentials = f"?key={key}&token={token}"

    def set_url(self, base_url, credentials):
        self.set_base_url(base_url)
        self.set_credentials(credentials)

    def send_request(self, method, endpoint, payload=None):
        url = f'{self.base_url}{endpoint}/{self.credentials}'
        log.info(f"Request: '{method}' to: {url}")
        try:
            if method in ['POST', 'PUT']:
                response = self.session.request(method, url, params=payload)
                log.info(f"Body: {payload}")
            else:
                response = self.session.request(method, url)
        except requests.exceptions.RequestException as error:
            log.error(f'API {method} request to {url} has failed with error: {error.response}')
            raise
        log.info(f"Status Code: {response.status_code}")
        return response

    def close_session(self):
        self.session.close()

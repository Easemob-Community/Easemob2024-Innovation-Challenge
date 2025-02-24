import logging
from typing import TypeAlias

import requests as r

from config import EASEMOB_ORGNAME, EASEMOB_APPNAME, EASEMOB_CLIENT_ID, EASEMOB_CLIENT_SECRET, EASEMOB_AI_SUPPORT_USER
from easemob import token_storage

logging.basicConfig(level=logging.INFO)

HOST = 'a1.easemob.com'

User: TypeAlias = str


def get_app_token() -> str:
    if token_storage.app_token:
        return token_storage.app_token
    url = f'https://{HOST}/{EASEMOB_ORGNAME}/{EASEMOB_APPNAME}/token'
    data = {
        'grant_type': 'client_credentials',
        'client_id': EASEMOB_CLIENT_ID,
        'client_secret': EASEMOB_CLIENT_SECRET,
    }
    response = r.post(url, json=data)
    jdata = response.json()
    token_storage.app_token = jdata['access_token']
    return token_storage.app_token


def send_text(to: User, text: str):
    if not to or not text:
        return
    url = f'https://{HOST}/{EASEMOB_ORGNAME}/{EASEMOB_APPNAME}/messages/users'
    token = get_app_token()
    headers = {
        'Authorization': f'Bearer {token}',
    }
    data = {
        'from': EASEMOB_AI_SUPPORT_USER,
        'to': [to],
        'type': 'text',
        'body': {
            'msg': text,
        }
    }
    resp = r.post(url, json=data, headers=headers)
    logging.info(resp.json())


if __name__ == '__main__':
    token = get_app_token()
    logging.info(f'token: {token}')
    send_text('test', 'Hello world')

import logging

from flask import Flask, request
from flask_cors import CORS

from deepseek import deepseek_srv
from easemob import easemob_srv

logging.basicConfig(level=logging.DEBUG)

app = Flask(__name__)

origins = [
    "http://127.0.0.1:5174",
    "http://localhost:5174",
    "file://",
]
CORS(app, origins=origins)

@app.get("/")
def root():
    return {"message": "Hello World"}


@app.post("/ai/msg")
def receive_msg():
    jdata = request.json
    logging.info(f"Received msg: {jdata}")
    sender = jdata["from"]
    if jdata['type'] != 'txt':
        easemob_srv.send_text(sender, '暂不支持该类型消息')
        return {"success": False, 'message': '暂不支持该类型消息'}
    resp_text = deepseek_srv.process_message(sender, jdata['msg'])
    easemob_srv.send_text(sender, resp_text)
    return {"success": True, "message": resp_text}


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000, debug=True)

import json
import logging

from openai import Client

from config import DEEPSEEK_API_KEY
from shop import shop_srv

logging.basicConfig(level=logging.INFO)

client = Client(api_key=DEEPSEEK_API_KEY, base_url="https://api.deepseek.com/v1")


def _send_message(messages: list[dict]) -> str:
    response = client.chat.completions.create(
        model="deepseek-chat",
        messages=messages,
        stream=False,
    )
    logging.info(f"[DS] RAW RESPONSE: {response}")
    return response.choices[0].message.content


def gen_goods_desc(mtext: str) -> str:
    messages = [
        {'role': 'system', 'content':
            '''
            你是一个智能客服，现在需要你根据内容生成一些商品介绍，限制100字以内。直接输出介绍内容即可
            '''},
        {'role': 'user', 'content': f'介绍一下商品: {mtext}'}
    ]
    resp = _send_message(messages)
    return resp


def gen_goods_compare(mtext: str) -> str:
    messages = [
        {'role': 'system', 'content':
            '''
            你是一个智能客服，现在需要你根据内容生成一些商品对比数据，限制100字以内。直接输出对比内容即可
            '''},
        {'role': 'user', 'content': f'对比一下商品: {mtext}'}
    ]
    resp = _send_message(messages)
    return resp


def gen_goods_activity(mtext: str) -> str:
    messages = [
        {'role': 'system', 'content':
            '''
            你是一个智能客服，现在需要你根据内容生成一些商品活动介绍，同时带有一些型号地区限制等,限制100字以内。直接输出活动内容即可
            '''},
        {'role': 'user', 'content': f'介绍一下活动: {mtext}'}
    ]
    resp = _send_message(messages)
    return resp


def post_process(msg: dict[str, str]) -> str:
    mtype = msg["type"]
    mtext = msg["text"]
    if mtype == "查询订单":
        return shop_srv.search_order(mtext)
    elif mtype == "商品介绍":
        return gen_goods_desc(mtext)
    elif mtype == '商品对比':
        return gen_goods_compare(mtext)
    elif mtype == '咨询活动':
        return gen_goods_activity(mtext)
    elif mtype == '其他':
        return mtext
    else:
        return mtext


def parse_json(rawdata: str) -> dict[str, str]:
    if rawdata.startswith("```json"):
        rawdata = rawdata.replace("```json", "")
    if rawdata.endswith("```"):
        rawdata = rawdata.replace("```", "")
    return json.loads(rawdata)


prompt = {'role': 'system', 'content':
    '''
    你是一个智能客服的语句分析专家，后续给你的所有文本数据，你都要返回JSON格式的数据。
    但是如果有人问你是谁，你要说你是一个智能客服。如果问一些和商城客服无关的话题，不要回答、或者简单的表示一下不太清楚就行。
    你要判断出当前文本的类型，比如: 商品介绍、商品对比、查询订单、咨询活动，不是这些的话，就返回type=其他，text是你回复的内容。
    假如是想查询订单，但是内容中没有订单号。则输出type=其他，text是告诉用户需要输入订单号才行。再输入订单号后，返回类似如下格式：{"type": "查询订单": "text": "123123123"}
    就是如果用户没有提供给你足够的信息，那么你需要输出type=其他的回复，让用户来进行补全你所需的数据。
    然后再把具体内容取出来，比如商品名称、订单号等。
    返回格式示例: {"type": "查询订单": "text": "123123123"}
    '''}

message_store: list[dict[str, str]] = []


def process_message(user: str, message: str) -> str:
    global message_store
    if len(message_store) > 20:
        message_store = message_store[:20]

    message_store.append(
        {'role': 'user', 'content': message}
    )
    # 原始回复
    resp = _send_message([prompt, ] + message_store)
    logging.info(f'[DS] RAW user: {user}, message: {resp}')
    # 再次处理
    text = post_process(parse_json(resp))
    message_store.append({'role': 'assistant', 'content': text})
    logging.info(f'[DS] PROCESSED user: {user}, message: {text}')
    return text


if __name__ == '__main__':
    process_message('test', '您好，能帮我写一个贪吃蛇游戏吗')

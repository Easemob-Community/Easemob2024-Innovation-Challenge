import random

def search_order(order_id: str) -> str:
    """
    订单查询
    :param order_id: 订单ID
    :return:
    """
    sts = __gen_fake_status(order_id)
    return sts[random.randint(0, len(sts) - 1)]


def __gen_fake_status(order_id: str) -> list[str]:
    """
    Fake状态 生成
    :param order_id:
    :return:
    """
    sts = [
        f'订单:{order_id} 不存在，请重新确认?',
        f'订单:{order_id} 正在处理中，稍后将送到您手中',
        f'订单:{order_id} 正在配送中，稍后将送到您手中',
        f'订单:{order_id} 已完成签收，如有疑问请继续提问',
        f'订单:{order_id} 已完成退款',
    ]
    return sts



if __name__ == '__main__':
    for i in range(3):
        print(search_order(str(i)))

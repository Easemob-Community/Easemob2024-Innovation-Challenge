import logging
import os
import time

from selenium import webdriver
from selenium.webdriver.chrome.options import Options

from config import EASEMOB_APPNAME, EASEMOB_ORGNAME, EASEMOB_AI_SUPPORT_USER, EASEMOB_AI_SUPPORT_PWD, SERVER_URL

logging.basicConfig(level=logging.INFO)


def set_options():
    chrome_options = Options()
    chrome_options.add_argument("--headless")
    chrome_options.add_argument("--disable-gpu")
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-extensions")
    chrome_options.add_argument("--allow-file-access-from-files")
    return chrome_options


def base_dir():
    return os.path.dirname(os.path.abspath(__file__))


config_scripts = f'''
window.appKey = "{EASEMOB_ORGNAME}#{EASEMOB_APPNAME}"
window.username = '{EASEMOB_AI_SUPPORT_USER}'
window.password = '{EASEMOB_AI_SUPPORT_PWD}'
window.apiUrl = '{SERVER_URL}'
'''


def run():
    opts = set_options()
    driver = webdriver.Chrome(options=opts)
    #
    html = os.path.join(base_dir(), 'dist', "index.html")
    driver.get(f'file://{html}')
    if driver.title != 'EASEMOB':
        logging.error('[EASEMOB_PROXY] load error')
        return
    logging.info('[EASEMOB_PROXY] load success')
    time.sleep(2)
    driver.execute_script(config_scripts)
    driver.execute_script('window.run()')
    # wait
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        pass
    finally:
        driver.quit()


if __name__ == '__main__':
    run()

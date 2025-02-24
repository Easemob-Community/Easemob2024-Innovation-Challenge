import os

from dotenv import dotenv_values

base_dir = os.path.dirname(__file__)

env_map = dotenv_values(os.path.join(base_dir, '.env'))

# DeepSeek
DEEPSEEK_API_KEY = env_map.get("DEEPSEEK_API_KEY")

# EaseMob
EASEMOB_ORGNAME = env_map.get("EASEMOB_ORGNAME")
EASEMOB_APPNAME = env_map.get("EASEMOB_APPNAME")

EASEMOB_CLIENT_ID = env_map.get("EASEMOB_CLIENT_ID")
EASEMOB_CLIENT_SECRET = env_map.get("EASEMOB_CLIENT_SECRET")

EASEMOB_AI_SUPPORT_USER = env_map.get("EASEMOB_AI_SUPPORT_USER")
EASEMOB_AI_SUPPORT_PWD = env_map.get("EASEMOB_AI_SUPPORT_PWD")

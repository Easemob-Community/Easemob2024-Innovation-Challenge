import {Component, useEffect} from "react";
import {Chat, ConversationList, rootStore, UIKitProvider, useClient,} from "easemob-chat-uikit";

import "easemob-chat-uikit/style.css";

let appKey: string;
let user: string;
let accessToken: string;


// 假装 后端获取账号信息
const getAccountMock = () => {
  appKey = "1189210720051209#ai-support"
  user = "test"
  accessToken = "YWMtyH0gmugqEe-Mmalm2LGArCXTctHC6kWtgtf8LqqN71WlMq6A6CkR75NgJx2ZByPEAwMAAAGU8x2eaDeeSAAxfHydR55Kl-wsvjdPsdL1YvqLBm2DyFEvH-WpKubeiA"
}

getAccountMock();

const ChatApp = () => {
  const client = useClient();
  useEffect(() => {
    // eslint-disable-next-line @typescript-eslint/no-unused-expressions
    client && client
      .open({
        user: user,
        accessToken: accessToken
      })
      .then(() => {
        // 创建会话
        rootStore.conversationStore.addConversation({
          unreadCount: 0,
          chatType: "singleChat", // 单聊和群聊分别为 'singleChat' 和 'groupChat'。
          conversationId: "ai", // 单聊为对端用户 ID，群聊为群组 ID。
          name: "客服", // 单聊为对端用户昵称，群聊为群组名称。
          lastMessage: {},
        });
      });
  }, [client]);

  return (
    <div style={{display: "flex", height: "80vh", width: "80%"}}>
      <div style={{width: "25%", border: "1px solid #ccc"}}>
        <ConversationList/>
      </div>
      <div style={{width: "75%", border: "1px solid #ccc"}}>
        <Chat/>
      </div>
    </div>
  );
};

class App extends Component {

  render() {
    return (
      <UIKitProvider
        initConfig={{
          appKey: appKey,
          userId: user,
          token: accessToken,
        }}
        local={{
          lng: "zh"
        }}
      >
        <div style={{display: "flex", justifyContent: "center", alignItems: "center"}}>
          <ChatApp/>
        </div>
      </UIKitProvider>
    );
  }
}

export default App;

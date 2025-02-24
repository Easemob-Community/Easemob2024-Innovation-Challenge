
import 'package:get/get.dart';
import 'package:im_flutter_sdk/im_flutter_sdk.dart';
import 'package:third_party_base/third_party_base.dart';

import '../../data/model/ai_model.dart';
import '../../data/model/chat2_model.dart';
import '../../data/model/params/ai2_param.dart';
import '../../data/model/params/ai_param.dart';
import '../../data/source/app_responsitory.dart';
import '../../utils/image_generator.dart';
import 'state.dart';

class ChartLogic extends GetxController  {
  final ChartState state = ChartState();

  late AIModel aiModel;
  late Ai2Parma payload;

  @override
  void onInit() {
    super.onInit();
    aiModel = Get.arguments;
    payload = Ai2Parma("MiniMax-Text-01",[Chat2Model("system",aiModel.name,aiModel.content)]);
  }

  // {
  // "content": "MM智能助理是一款由MiniMax自研的，没有调用其他产品的接口的大型语言模型。MiniMax是一家中国科技公司，一直致力于进行大模型相关的研究。",
  // "role": "system",
  // "name": "MM智能助理"
  // },
  // {
  // "role":"user",
  // "name":"用户", # 选填字段
  // "content":"你好"
  // }

  void send(String contentm)async{
    state.chat.add(Chat(true, contentm));
    update();
    var msg = EMMessage.createTxtSendMessage(
      targetId: "AI",
      content: contentm,
    );
    EMClient.getInstance.chatManager.sendMessage(msg);
    payload..messages.add(Chat2Model("user","用户","给我输出一个小红书文案，我只要内容，其他多余的东西不要说，大概500字，标题是："+contentm));
    var data = await AppResponsitory.instance.chatcompletionV2(payload);
    if(data.baseResp.statusCode!=0){
      TipToast.showToast("请求异常");
      EasyLoading.dismiss();
    }else{
      await ImageGenerator.generateImages(Get.context!, contentm, data.choices[0].message.content, onImageGeneratedCallback: (img){
        state.chat.add(Chat(false, data.choices[0].message.content)..image = img);
      });
      EasyLoading.dismiss();

      // payload..messages.add(Chat2Model("BOT", aiModel.name,data.reply));
    }

    update();
  }


}

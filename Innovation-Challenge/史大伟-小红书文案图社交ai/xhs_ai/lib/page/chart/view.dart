import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:third_party_base/third_party_base.dart';
import '../../app/config.dart';
import '../../app/router_name.dart';
import '../../data/model/ai_model.dart';
import 'logic.dart';
import 'package:base_ui/base_ui.dart';

class ChartPage extends StatelessWidget {
  ChartPage({Key? key}) : super(key: key);

  final logic = Get.put(ChartLogic());
  final state = Get.find<ChartLogic>().state;

  TextEditingController _contextController =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartLogic>(builder: (logic){
      return Scaffold(
          appBar: AppBar(
            title: Text("与${logic.aiModel.name}聊天中"),
            leading: IconButton(
              tooltip: '返回上一页',
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
              },
            ),
          ), body: Column(children: [

        Expanded(flex: 1,child: ListView.builder(
            itemCount: state.chat.length,
            itemBuilder: (BuildContext context, int index) {
              return _chatLayout(state.chat[index]);
              // return ListTile(title: Text("$index"));
            }
        )),
        Container(
          color: LibColors.libColorLightgrey,
          child: Row(children: [
            Expanded(child: TextField(controller: _contextController,decoration: const InputDecoration(
                hintText: "内容",
                prefixIcon: Icon(Icons.person)
            ),),flex: 1,),
            ElevatedButton(onPressed: (){
              EasyLoading.show(status: "发送消息中",maskType: EasyLoadingMaskType.black);
              logic.send(_contextController.text);
              _contextController.text = "";
            }, child: Text("send"))
          ],),
        )
      ],)
      );
    });


  }



  Widget _chatLayout(Chat item){
    Widget right = Container();
    Widget left = Container();
    if(!item.isRight){
      right = Container(
          width: 50,
          height: 50,
          child: Image.asset(logic.aiModel.img));
    }else{
      left = Container(width: 50,height: 50,child: Icon(Icons.account_circle),);
    }

    if(item.image!=null){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          right,
          Expanded(
            flex: 1,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: item.image!.length,
              itemBuilder: (BuildContext context, int index) {
                File f = File(item.image![index]);
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Image.file(f, fit: BoxFit.cover),
                    ),
                    if (index < item.image!.length - 1)
                      SizedBox(width: MediaQuery.of(context).size.width * 0.6,
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),)
                  ],
                );
              },
            ),
          ),
          Container(width: 50,height: 100,child: ElevatedButton(child: Text("保存到相册"),onPressed: (){
            item.image!.forEach((element) {
              _saveImageToGallery(element);
            });
          },),),
        ],),
      );
    }else{
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          right,
          Expanded(flex:1,child: Text(item.text,textAlign: item.isRight?TextAlign.right:TextAlign.left,)),
          left,
        ],),
      );
    }

  }


  Future<void> _saveImageToGallery(String localImagePath) async {
    try {
      // 检查文件是否存在
      File file = File(localImagePath);
      if (!await file.exists()) {
        print('File does not exist: $localImagePath');
        return;
      }

      // 保存到图库
      final result = await ImageGallerySaver.saveFile(localImagePath);
      print('Image saved to gallery: $result');
    } catch (e) {
      print('Error saving image: $e');
    }
  }
}
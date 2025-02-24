import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../utils/image_generator.dart';


class ABCD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Image Generator')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              // 调用工具类生成图片
              await ImageGenerator.generateImages(context, '房价还会降么',
                  """
  最近很多朋友都在讨论一个话题：房价还会降么？这个问题不仅关乎刚需购房者，也牵动着无数投资者的心。今天就来聊聊我的看法。

  首先，我们得明白，房价的走势受到多种因素的影响，包括宏观经济环境、货币政策、市场供需关系以及政策调控等。从目前的情况来看，房地产市场已经进入了一个新的阶段。

  **1. 政策调控的影响**

  近年来，国家对房地产市场的调控政策不断加码，“房住不炒”的定位非常明确。各地也纷纷出台了限购、限贷、限售等政策，目的就是为了抑制房价过快上涨。从这个角度来看，政策层面并不支持房价大幅上涨。

  **2. 市场供需关系**

  从供需角度来看，一线城市和部分热点二线城市由于人口持续流入，购房需求依然旺盛，房价相对坚挺。但一些三四线城市
  """);
              // await ImageGenerator.generateImage(context, 'My Title', 'This is the content of the imageThis is the con'
              //     'tent of the imageThis is the conte'
              //     'nt of the imageThis is the content of '
              //     'the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the imageThis is the content of the image.');
            },
            child: Text('Generate Image'),
          ),
        ),
      ),
    );
  }
}
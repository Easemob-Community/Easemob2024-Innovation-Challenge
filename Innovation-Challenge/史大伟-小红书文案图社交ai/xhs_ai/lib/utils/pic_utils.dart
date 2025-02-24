// import 'dart:typed_data';
// import 'package:flutter/services.dart'; // 添加导入
// import 'package:image/image.dart' as img;
// import 'package:image_editor_plus/image_editor_plus.dart';
//
// class PicUtils {
//   static Future<Uint8List> generateImage(String title, String content) async {
//     // 创建一个空白的白色背景图像
//     final image = img.Image(800, 600, format: img.Format.png) // 修正 img.Format.pn 为 img.Format.png
//       ..fill(img.ColorRgb8(255, 255, 255));
//
//     // 加载字体
//     final font = await _loadFont();
//
//     // 绘制标题
//     img.drawString(
//       image,
//       font,
//       400, // x position
//       100, // y position
//       title,
//       color: img.ColorRgb8(0, 0, 0),
//       anchor: img.Anchor.topCenter,
//     );
//
//     // 绘制内容
//     img.drawString(
//       image,
//       font,
//       400, // x position
//       300, // y position
//       content,
//       color: img.ColorRgb8(0, 0, 0),
//       anchor: img.Anchor.topCenter,
//     );
//
//     // 将图像转换为 Uint8List
//     final png = img.encodePng(image);
//     return png;
//   }
//
//   static Future<img.Font> _loadFont() async {
//     // 假设我们有一个字体文件 assets/fonts/Roboto-Regular.ttf
//     final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
//     return img.decodeFont(fontData.buffer.asUint8List());
//   }
// }
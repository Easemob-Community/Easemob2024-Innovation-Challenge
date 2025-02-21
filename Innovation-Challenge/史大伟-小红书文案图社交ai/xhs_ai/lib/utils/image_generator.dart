import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:third_party_base/third_party_base.dart';

typedef void OnImageGeneratedCallback(List<String> images);

class ImageGenerator {
  static const double width = 720;
  static const double height = 960;
  static const double padding = 20.0;
  static const double fontSize = 40;
  static const double minLineHeight = fontSize * 1.2; // 最小行高

  static Future<void> generateImages(BuildContext context, String title, String content, {OnImageGeneratedCallback? onImageGeneratedCallback}) async {
    if (await _checkAndRequestPermissions()) {
      final titleImage = await _generateTitleImage(title);
      final titleFilePath = await _saveImage(titleImage, 'title_image.png');

      final contentImages = await _generateContentImages(content);
      List<String> img = [titleFilePath];
      for (int i = 0; i < contentImages.length; i++) {
        final filePath = await _saveImage(contentImages[i], 'content_image_$i.png');
        img.add(filePath);
      }
      onImageGeneratedCallback?.call(img);
    }
  }

  static Future<Uint8List> _generateTitleImage(String title) async {
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), Paint()..color = Colors.white);

    final textPainter = TextPainter(
      text: TextSpan(
        text: title,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: width - 2 * padding);

    final titleOffset = Offset((width - textPainter.width) / 2, (height - textPainter.height) / 2);
    textPainter.paint(canvas, titleOffset);

    final image = await recorder.endRecording().toImage(width.toInt(), height.toInt());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  static Future<List<Uint8List>> _generateContentImages(String content) async {
    final List<Uint8List> images = [];
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    final List<String> lines = _splitContentIntoLines(
      content,
      width - 2 * padding,
      fontSize,
    );

    int lineIndex = 0;
    while (lineIndex < lines.length) {
      final recorder = ui.PictureRecorder();
      final canvas = ui.Canvas(recorder);
      canvas.drawRect(Rect.fromLTWH(0, 0, width, height), Paint()..color = Colors.white);

      double yOffset = padding;
      bool hasContent = false;

      while (lineIndex < lines.length) {
        final line = lines[lineIndex];
        textPainter.text = TextSpan(
          text: line,
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.black,
          ),
        );
        textPainter.layout();

        final lineHeight = textPainter.height.clamp(minLineHeight, double.infinity);

        // 分页检查：至少能容纳一行内容
        if (yOffset + lineHeight > height - padding) {
          // 新页面至少要能显示一行
          if (!hasContent && lineIndex == 0) {
            // 异常情况：单行高度超过画布
            throw Exception('Single line exceeds canvas height');
          }
          break;
        }

        textPainter.paint(canvas, Offset(padding, yOffset));
        yOffset += lineHeight;
        lineIndex++;
        hasContent = true;
      }

      final image = await recorder.endRecording().toImage(width.toInt(), height.toInt());
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      images.add(byteData!.buffer.asUint8List());
    }

    return images;
  }

  static List<String> _splitContentIntoLines(
      String content,
      double maxWidth,
      double fontSize,
      ) {
    final List<String> lines = [];
    final characters = content.split('');
    String currentLine = '';

    for (final char in characters) {
      String testLine = currentLine + char;
      double testWidth = _getTextWidth(testLine, fontSize);

      if (testWidth <= maxWidth) {
        currentLine = testLine;
      } else {
        if (currentLine.isNotEmpty) {
          lines.add(currentLine);
        }
        currentLine = char;
      }
    }

    if (currentLine.isNotEmpty) {
      lines.add(currentLine);
    }

    return lines;
  }

  static double _getTextWidth(String text, double fontSize) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: fontSize),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }

  static Future<String> _saveImage(Uint8List pngBytes, String fileName) async {
    final file = File(StorageUtil.getWritePath(fileName, StorageType.typeCache)!);
    await file.writeAsBytes(pngBytes);
    return file.path;
  }

  static Future<bool> _checkAndRequestPermissions() async {
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      final result = await Permission.storage.request();
      return result.isGranted;
    }
    return true;
  }
}
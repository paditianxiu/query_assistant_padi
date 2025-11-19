import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final currentBanner = 0.obs;

  final bannerList = <String>[
    "https://picsum.photos/800/300?1",
    "https://picsum.photos/800/300?2",
    "https://picsum.photos/800/300?3",
    "https://picsum.photos/800/300?4",
    "https://picsum.photos/800/300?5",
    "https://picsum.photos/800/300?6",
    "https://picsum.photos/800/300?7",
    "https://picsum.photos/800/300?8",
    "https://picsum.photos/800/300?9",
  ].obs;

  final tools = [
    {"icon": Icons.qr_code_scanner, "name": "扫码"},
    {"icon": Icons.image_search, "name": "以图搜图"},
    {"icon": Icons.calculate, "name": "计算器"},
    {"icon": Icons.color_lens, "name": "取色器"},
    {"icon": Icons.lock, "name": "加密解密"},
    {"icon": Icons.wifi, "name": "WiFi工具"},
    {"icon": Icons.android, "name": "APK分析"},
    {"icon": Icons.text_snippet, "name": "文本工具"},
    {"icon": Icons.location_on, "name": "位置工具"},
    {"icon": Icons.photo, "name": "图片工具"},
  ].obs;
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();

  RxBool isDarkMode = false.obs;

  Rx<MaterialColor> primaryColor = Colors.blue.obs;

  int get index => _box.read('primaryColorIndex') ?? 0;

  final List<MaterialColor> colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
  ];

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = _box.read('isDarkMode') ?? false;
    int savedColorIndex = _box.read('primaryColorIndex') ?? 0;
    primaryColor.value = colors[savedColorIndex];
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _box.write('isDarkMode', isDarkMode.value);
  }

  void changeColor(int index) {
    primaryColor.value = colors[index];
    _box.write('primaryColorIndex', index);
  }
}

import 'package:get/get.dart';

class ToolsController extends GetxController {
  final navIndex = 0.obs;

  void changeNavIndex(int i) => navIndex.value = i;
}

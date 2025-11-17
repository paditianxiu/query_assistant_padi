import 'package:get/get.dart';

class HomeController extends GetxController {
  final navIndex = 1.obs;

  void changeNavIndex(int i) => navIndex.value = i;
}

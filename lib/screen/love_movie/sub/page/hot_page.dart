import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:query_assistant_padi/screen/love_movie/controller.dart';
import 'package:query_assistant_padi/screen/love_movie/page.dart';

class HotPage extends StatefulWidget {
  const HotPage({super.key});

  @override
  State<HotPage> createState() => _HotPageState();
}

class _HotPageState extends State<HotPage> {
  final LoveMovieController controller = Get.put(LoveMovieController(), tag: "hot");

  @override
  void initState() {
    super.initState();
    controller.getHotData();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = (constraints.maxWidth ~/ 130).clamp(3, 10);
        return Obx(() => buildMovieGrid(controller.subjects, crossAxisCount));
      },
    );
  }
}

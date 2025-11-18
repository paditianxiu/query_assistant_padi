import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:query_assistant_padi/screen/love_movie/controller.dart';
import 'package:query_assistant_padi/screen/love_movie/page.dart';

class ComingSoonPage extends StatefulWidget {
  const ComingSoonPage({super.key});

  @override
  State<ComingSoonPage> createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends State<ComingSoonPage> {
  final LoveMovieController controller = Get.put(LoveMovieController(), tag: "coming");

  @override
  void initState() {
    super.initState();
    controller.getLaterData();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = (constraints.maxWidth ~/ 130).clamp(3, 10);
        return Obx(() => buildMovieGrid(controller.laterData, crossAxisCount));
      },
    );
  }
}

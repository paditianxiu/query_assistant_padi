import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:query_assistant_padi/screen/love_movie/controller.dart';
import 'package:query_assistant_padi/screen/love_movie/page.dart';

class Top250Page extends StatefulWidget {
  const Top250Page({super.key});

  @override
  State<Top250Page> createState() => _Top250PageState();
}

class _Top250PageState extends State<Top250Page> {
  final LoveMovieController controller = Get.put(LoveMovieController(), tag: "top250");

  @override
  void initState() {
    super.initState();
    controller.getTop250Data();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = (constraints.maxWidth ~/ 130).clamp(3, 10);
        return Obx(() => buildMovieGrid(controller.top250Data, crossAxisCount));
      },
    );
  }
}

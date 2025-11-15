import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:query_assistant_padi/screen/love_movie/controller.dart';
import 'package:query_assistant_padi/screen/love_movie/movie_card.dart';

class LoveMoviePage extends StatelessWidget {
  final LoveMovieController controller = Get.put(LoveMovieController());

  LoveMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("爱搜片")),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          int crossAxisCount = (width ~/ 130).clamp(2, 10);
          return Obx(() {
            final subjects = controller.subjects;
            if (subjects.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 0.6,
              ),
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final item = subjects[index];
                return MovieCard(title: item.title, imgUrl: item.cover, rate: item.rate, canSearch: true, index: index);
              },
            );
          });
        },
      ),
    );
  }
}

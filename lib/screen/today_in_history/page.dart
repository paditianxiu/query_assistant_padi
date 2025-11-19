import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:query_assistant_padi/screen/today_in_history/detail.dart';
import 'package:query_assistant_padi/screen/today_in_history/type.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'controller.dart';

class TodayInHistoryPage extends StatefulWidget {
  const TodayInHistoryPage({super.key});

  @override
  State<TodayInHistoryPage> createState() => _TodayInHistoryPageState();
}

class _TodayInHistoryPageState extends State<TodayInHistoryPage> {
  final TodayInHistoryController controller = Get.put(TodayInHistoryController());

  @override
  void initState() {
    super.initState();
    controller.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    const crossAxisCount = 2;

    return Scaffold(
      appBar: AppBar(title: const Text("历史上的今天")),
      body: Obx(() {
        final data = controller.data;
        return MasonryGridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemCount: data.isEmpty ? crossAxisCount * 5 : data.length,
          itemBuilder: (context, index) {
            return data.isEmpty ? _buildSkeletonCard(context) : _buildDataCard(data[index]);
          },
        );
      }),
    );
  }

  Widget _buildSkeletonCard(BuildContext context) {
    final imgHeight = randomHeight(100, 200).toDouble();

    Color skeletonColor() {
      final brightness = Theme.of(context).brightness;
      return brightness == Brightness.dark ? Colors.grey.shade800 : Colors.grey.shade300;
    }

    final sk = skeletonColor();

    return Skeletonizer(
      enabled: true,
      child: Card(
        elevation: 1,
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            Container(
              height: 16,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: sk, borderRadius: BorderRadius.circular(4)),
            ),

            const SizedBox(height: 8),

            Container(
              height: 16,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(color: sk, borderRadius: BorderRadius.circular(4)),
            ),

            const SizedBox(height: 8),

            Container(
              height: imgHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                color: sk,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCard(TodayInHistodayType item) {
    final imageTag = item.title;
    final subtitleTag = "${item.title}-subtitle";

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Get.to(() => TodayInHistodayDetailPage(item: item, imageTag: imageTag, subtitleTag: subtitleTag));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item.title.split("年")[0]}年",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),

                  Hero(
                    tag: subtitleTag,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        item.title.split("年")[1].replaceFirst(RegExp(r'^-'), ''),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (item.cover.isNotEmpty)
              Hero(
                tag: imageTag,
                child: CachedNetworkImage(imageUrl: item.cover, height: 200, width: double.infinity, fit: BoxFit.cover),
              ),
          ],
        ),
      ),
    );
  }
}

int randomHeight(int min, int max) {
  final random = Random();
  return random.nextInt(max - min + 1) + min;
}

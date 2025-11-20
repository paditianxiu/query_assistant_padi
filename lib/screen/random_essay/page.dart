import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:query_assistant_padi/screen/random_essay/controller.dart';

class RandomEssayPage extends StatefulWidget {
  const RandomEssayPage({super.key});

  @override
  State<RandomEssayPage> createState() => _RandomEssayPageState();
}

class _RandomEssayPageState extends State<RandomEssayPage> {
  final RandomEssayController controller = Get.put(RandomEssayController());

  @override
  void initState() {
    super.initState();
    controller.getRandomEssay();
  }

  void _copyText() {
    final textToCopy = "${controller.title.value}\n${controller.author.value}\n${controller.content.value}";
    Clipboard.setData(ClipboardData(text: textToCopy));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('已复制')));
  }

  void _refreshContent() {
    controller.getRandomEssay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            actions: [
              IconButton(icon: const Icon(Icons.copy), onPressed: _copyText, tooltip: '复制'),
              IconButton(icon: const Icon(Icons.refresh), onPressed: _refreshContent, tooltip: '刷新'),
            ],
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsetsDirectional.only(start: 56, bottom: 8),
              title: Obx(() {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.title.value.isEmpty ? '随机一文' : controller.title.value,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 2),
                    Text(controller.author.value, style: const TextStyle(fontSize: 12)),
                  ],
                );
              }),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Obx(() {
                if (controller.content.value.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Html(
                  data: controller.content.value,
                  style: {"*": Style(fontSize: FontSize(16), lineHeight: LineHeight(1.5))},
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

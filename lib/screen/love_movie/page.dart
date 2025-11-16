import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:query_assistant_padi/screen/love_movie/controller.dart';
import 'package:query_assistant_padi/screen/love_movie/movie_card.dart';

class LoveMoviePage extends StatefulWidget {
  const LoveMoviePage({super.key});

  @override
  State<LoveMoviePage> createState() => _LoveMoviePageState();
}

class _LoveMoviePageState extends State<LoveMoviePage> with SingleTickerProviderStateMixin {
  final LoveMovieController controller = Get.put(LoveMovieController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    controller.getHotData();
    controller.getTop250Data();
    controller.getLaterData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("爱搜片"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.whatshot), Text('热门推荐')]),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.bookmark_outline), SizedBox(width: 2.0), Text('豆瓣排行')],
              ),
            ),
            Tab(
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.event_note), Text('即将上映')]),
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          int crossAxisCount = (width ~/ 130).clamp(3, 10);
          return TabBarView(
            controller: _tabController,
            children: [
              // 热门推荐
              Obx(() => buildMovieGrid(controller.subjects, crossAxisCount)),
              // 豆瓣 Top250
              Obx(() => buildMovieGrid(controller.top250Data, crossAxisCount)),
              // 即将上映
              Obx(() => buildMovieGrid(controller.laterData, crossAxisCount)),
            ],
          );
        },
      ),
    );
  }
}

Widget buildMovieGrid(List items, int crossAxisCount) {
  return GridView.builder(
    physics: const BouncingScrollPhysics(),
    padding: const EdgeInsets.all(8),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      childAspectRatio: 0.6,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
    ),
    itemCount: items.isEmpty ? crossAxisCount * 5 : items.length,
    itemBuilder: (context, index) {
      if (items.isEmpty) {
        return MovieCard(canSearch: false, index: index, isLoading: true);
      } else {
        final item = items[index];
        return MovieCard(title: item.title, imgUrl: item.cover, rate: item.rate, canSearch: true, index: index);
      }
    },
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:query_assistant_padi/controllers/theme_controller.dart';
import 'package:query_assistant_padi/screen/love_movie/controller.dart';
import 'package:query_assistant_padi/screen/love_movie/home_tab_page.dart';
import 'package:query_assistant_padi/screen/love_movie/movie_card.dart';
import 'package:query_assistant_padi/screen/love_movie/sub/category_page.dart';
import 'package:query_assistant_padi/screen/love_movie/sub/movie_list_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class LoveMoviePage extends StatefulWidget {
  const LoveMoviePage({super.key});

  @override
  State<LoveMoviePage> createState() => _LoveMoviePageState();
}

class _LoveMoviePageState extends State<LoveMoviePage> with SingleTickerProviderStateMixin {
  final LoveMovieController controller = Get.put(LoveMovieController());
  final ThemeController themeController = Get.put(ThemeController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(title: const Text("爱搜片")),
        body: LazyLoadIndexedStack(
          index: controller.navIndex.value,
          children: [HomeTabPage(), MovieListPage(), CategoryPage()],
        ),
        bottomNavigationBar: Material(
          color: themeController.isDarkMode.value ? Colors.black : Colors.white,
          elevation: 10,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: SalomonBottomBar(
            selectedItemColor: themeController.primaryColor.value,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            currentIndex: controller.navIndex.value,
            onTap: controller.changeNavIndex,
            items: [
              SalomonBottomBarItem(icon: Icon(Icons.home_outlined), title: Text("主页")),
              SalomonBottomBarItem(icon: Icon(Icons.movie_outlined), title: Text("片单")),
              SalomonBottomBarItem(icon: Icon(Icons.category_outlined), title: Text("分类")),
            ],
          ),
        ),
      );
    });
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

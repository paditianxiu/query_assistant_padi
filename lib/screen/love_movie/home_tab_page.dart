import 'package:flutter/material.dart';
import 'package:query_assistant_padi/screen/love_movie/sub/page/hot_page.dart';
import 'package:query_assistant_padi/screen/love_movie/sub/page/top250_page.dart';
import 'package:query_assistant_padi/screen/love_movie/sub/page/coming_soon_page.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBar(
            controller: _tab,
            tabs: const [
              Tab(icon: Icon(Icons.whatshot), text: "热门推荐"),
              Tab(icon: Icon(Icons.bookmark_outline), text: "豆瓣排行"),
              Tab(icon: Icon(Icons.event_note), text: "即将上映"),
            ],
          ),
          Expanded(
            child: TabBarView(controller: _tab, children: [HotPage(), Top250Page(), ComingSoonPage()]),
          ),
        ],
      ),
    );
  }
}

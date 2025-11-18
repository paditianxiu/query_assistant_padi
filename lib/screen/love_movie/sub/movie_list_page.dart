import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:query_assistant_padi/screen/love_movie/controller.dart';
import 'package:query_assistant_padi/screen/love_movie/douban_play_list_type.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  late final LoveMovieController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(LoveMovieController());
    controller.getDoubanPlaylists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        final list = controller.doubanPlayLists;
        if (list.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: list.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.78,
          ),
          itemBuilder: (_, i) => PlaylistCard(item: list[i]),
        );
      }),
    );
  }
}

class PlaylistCard extends StatelessWidget {
  final PlaylistTypeItem item;
  const PlaylistCard({super.key, required this.item});

  static const headers = {
    'User-Agent':
        'Rexxar-Core/0.1.3 api-client/1 com.douban.frodo/7.112.0(337) Android/33 product/mondrian vendor/Xiaomi model/23013RK75C brand/Redmi  rom/miui6  network/wifi  udid/7307ac14a094763e609fe3058d6fcabc41a502fd  platform/mobile  foldable/0 nd/1 lt/2 com.douban.frodo/7.112.0(337) Rexxar/1.2.151  platform/mobile 1.2.151',
    'authorization': 'Bearer 25ebb471a554053c71c31d54effc0fb4',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 16 / 12,
                  child: CachedNetworkImage(
                    imageUrl: item.headerBgImage,
                    httpHeaders: headers,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[200],
                      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[200],
                      child: const Center(child: Icon(Icons.broken_image)),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                  child: const Text("豆", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ),
              Positioned(
                left: 6,
                bottom: 6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: SizedBox(
                    width: 36,
                    height: 50,
                    child: CachedNetworkImage(
                      imageUrl: item.coverUrl,
                      httpHeaders: headers,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(color: Colors.grey[200]),
                      errorWidget: (context, url, error) =>
                          Container(color: Colors.grey[200], child: const Icon(Icons.broken_image, size: 16)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text("共${item.itemsCount}部", style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}

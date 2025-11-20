import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:query_assistant_padi/screen/love_movie/sub/page/movie_list_detail_page.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:query_assistant_padi/controllers/theme_controller.dart';
import 'package:query_assistant_padi/screen/love_movie/controller.dart';
import 'package:query_assistant_padi/screen/love_movie/sub/type/douban_play_list_type.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  late final LoveMovieController controller;
  late ThemeController themeController = Get.find();

  @override
  void initState() {
    super.initState();
    controller = Get.put(LoveMovieController());
    themeController = Get.put(ThemeController());
    controller.getDoubanPlayList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final list = controller.doubanPlayLists;

        final isLoading = list.isEmpty;
        final List<PlaylistTypeItem?> data = isLoading ? List<PlaylistTypeItem?>.filled(8, null) : list;

        return Skeletonizer(
          enabled: isLoading,
          effect: ShimmerEffect(
            baseColor: themeController.grey,
            highlightColor: themeController.isDarkMode() ? Colors.grey.shade700 : Colors.grey.shade100,
            duration: Duration(milliseconds: 1000),
          ),
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: data.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.78,
            ),
            itemBuilder: (_, i) {
              return PlaylistCard(item: data[i], themeController: themeController);
            },
          ),
        );
      }),
    );
  }
}

class PlaylistCard extends StatelessWidget {
  final PlaylistTypeItem? item;
  final ThemeController themeController;
  const PlaylistCard({super.key, required this.item, required this.themeController});

  static const headers = {
    'User-Agent':
        'Rexxar-Core/0.1.3 api-client/1 com.douban.frodo/7.112.0(337) Android/33 product/mondrian vendor/Xiaomi model/23013RK75C brand/Redmi rom/miui6 network/wifi udid/7307ac14a094763e609fe3058d6fcabc41a502fd platform/mobile 1.2.151',
    'authorization': 'Bearer 25ebb471a554053c71c31d54effc0fb4',
  };

  @override
  Widget build(BuildContext context) {
    final isSkeleton = item == null;

    if (isSkeleton) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16 / 12,
              child: Container(color: themeController.grey),
            ),
          ),
          const SizedBox(height: 8),
          Container(height: 16, width: 120, color: themeController.grey),
          const SizedBox(height: 4),
          Container(height: 12, width: 60, color: themeController.grey),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 16 / 12,
                child: InkWell(
                  onTap: () => Get.to(() => MovieListDetailPage(id: item?.id ?? "")),
                  child: Ink(
                    color: Get.theme.colorScheme.surfaceContainerHighest,
                    child: CachedNetworkImage(
                      imageUrl: item?.headerBgImage ?? "",
                      httpHeaders: headers,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(color: themeController.grey),
                      errorWidget: (_, __, ___) => Icon(Icons.broken_image),
                    ),
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
                child: const Text(
                  "豆",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
            Positioned(
              left: 6,
              bottom: 6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  width: 50,
                  height: 70,
                  child: CachedNetworkImage(
                    imageUrl: item?.coverUrl ?? "",
                    httpHeaders: headers,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(color: themeController.grey),
                    errorWidget: (_, __, ___) => Icon(Icons.broken_image),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          item!.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text("共${item!.itemsCount}部", style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

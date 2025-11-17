import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:query_assistant_padi/screen/image_view_page.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:query_assistant_padi/screen/wallpaper_collection/detail_controller.dart';

class WallpaperCollectionDetailPage extends StatefulWidget {
  final String id;
  const WallpaperCollectionDetailPage({super.key, required this.id});

  @override
  State<WallpaperCollectionDetailPage> createState() => _WallpaperCollectionDetailPageState();
}

class _WallpaperCollectionDetailPageState extends State<WallpaperCollectionDetailPage> {
  late final controller = Get.put(WallpaperCollectionDetailController(widget.id));
  final er = EasyRefreshController(controlFinishRefresh: true, controlFinishLoad: true);
  var firstLoading = true.obs;

  @override
  void initState() {
    super.initState();
    controller.refreshData().then((_) {
      firstLoading.value = false;
      er.finishRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("壁纸分类详情")),
      body: Obx(
        () => Skeletonizer(
          enabled: firstLoading.value,
          child: EasyRefresh(
            controller: er,
            onRefresh: () async {
              await controller.refreshData();
              firstLoading.value = false;
              er.finishRefresh();
              er.resetFooter();
            },
            onLoad: () async {
              await controller.loadMore();
              if (controller.noMore.value) {
                er.finishLoad(IndicatorResult.noMore);
              } else {
                er.finishLoad();
              }
            },
            child: MasonryGridView.count(
              padding: const EdgeInsets.all(12),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              itemCount: firstLoading.value ? 10 : controller.list.length,
              itemBuilder: (context, i) {
                if (firstLoading.value) {
                  return Container(
                    height: 200 + (i % 3) * 40,
                    decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(12)),
                  );
                }
                final item = controller.list[i];
                return GestureDetector(
                  onTap: () {
                    Get.to(ImageViewPage(imageUrl: item.thumb));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(imageUrl: item.thumb, fit: BoxFit.cover),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

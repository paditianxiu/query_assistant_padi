import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:query_assistant_padi/screen/wallpaper_collection/contorller.dart';
import 'package:query_assistant_padi/screen/wallpaper_collection/detail.dart';

import 'package:skeletonizer/skeletonizer.dart';
import 'package:query_assistant_padi/screen/wallpaper_collection/type.dart';

class WallpaperCollectionPage extends StatelessWidget {
  WallpaperCollectionPage({super.key});

  final controller = Get.put(WallpaperCollectionController());

  @override
  Widget build(BuildContext context) {
    controller.getHomeData();

    return Scaffold(
      appBar: AppBar(title: const Text("壁纸分类"), elevation: 0),
      body: Obx(() {
        final hasData = controller.homeData.isNotEmpty;

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: hasData ? controller.homeData.length : 16,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (_, i) {
            if (!hasData) {
              return _buildSkeletonCard(context);
            }
            final item = controller.homeData[i];
            return _buildCategoryCard(context, item);
          },
        );
      }),
    );
  }

  Widget _buildCategoryCard(BuildContext context, Category item) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (item.id.isNotEmpty) {
              Get.to(WallpaperCollectionDetailPage(id: item.id));
            }
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: item.cover,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Skeleton.shade(child: Container(color: Colors.grey)),
                  errorWidget: (_, __, ___) => Container(color: Theme.of(context).colorScheme.surfaceContainerHigh),
                ),
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black.withValues(alpha: 0.6), Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      shadows: const [Shadow(color: Colors.black, blurRadius: 4)],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonCard(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Skeletonizer(
        enabled: true,
        effect: const ShimmerEffect(),
        child: Stack(
          children: [
            Positioned.fill(
              child: Skeleton.shade(child: Container(color: Colors.grey)),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Skeleton.shade(
                child: Container(height: 20, margin: const EdgeInsets.all(12), color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

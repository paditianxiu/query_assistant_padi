import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class NoCacheManager extends CacheManager {
  static const key = "noCache";

  NoCacheManager() : super(Config(key, stalePeriod: Duration.zero, maxNrOfCacheObjects: 0));
}

class ImageViewPage extends StatelessWidget {
  final String imageUrl;
  final bool cache;

  const ImageViewPage({super.key, required this.imageUrl, this.cache = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("图片详情")),
      body: Container(
        color: Colors.black,
        child: PhotoView(
          imageProvider: CachedNetworkImageProvider(
            imageUrl,
            cacheManager: cache ? DefaultCacheManager() : NoCacheManager(),
          ),
        ),
      ),
    );
  }
}

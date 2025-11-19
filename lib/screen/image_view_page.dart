import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewPage extends StatelessWidget {
  final String imageUrl;

  const ImageViewPage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("图片详情")),
      body: Container(
        color: Colors.black,
        child: PhotoView(imageProvider: CachedNetworkImageProvider(imageUrl)),
      ),
    );
  }
}

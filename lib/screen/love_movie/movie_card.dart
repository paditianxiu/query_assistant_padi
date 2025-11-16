import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MovieCard extends StatelessWidget {
  final String? title;
  final String? imgUrl;
  final String? rate;
  final bool canSearch;
  final int index;
  final bool isLoading;

  const MovieCard({
    super.key,
    this.title,
    this.imgUrl,
    this.rate,
    required this.canSearch,
    required this.index,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: [
            Column(
              children: [
                // 图片部分
                Expanded(
                  child: isLoading
                      ? Skeletonizer(
                          enabled: true,
                          child: Container(width: double.infinity, height: 150, color: Colors.grey.shade300),
                        )
                      : CachedNetworkImage(
                          httpHeaders: const {'User-Agent': 'PostmanRuntime/7.37.0'},
                          width: double.infinity,
                          height: 150,
                          imageUrl: imgUrl ?? "",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Skeletonizer(
                            enabled: true,
                            child: Container(width: double.infinity, height: 150, color: Colors.grey.shade300),
                          ),
                          errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                        ),
                ),
                // 标题部分
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: isLoading
                      ? Skeletonizer(
                          enabled: true,
                          child: Container(width: double.infinity, height: 16, color: Colors.grey.shade300),
                        )
                      : Text(title ?? "", textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            // 评分部分
            if (rate != null && rate!.isNotEmpty)
              Positioned(
                left: 0,
                top: 10,
                child: isLoading
                    ? Skeletonizer(
                        enabled: true,
                        child: Container(
                          width: 40,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(95),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(50.0),
                            topRight: Radius.circular(50.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(rate!, style: const TextStyle(color: Colors.white, fontSize: 13)),
                        ),
                      ),
              ),
          ],
        ),
      ),
    );
  }
}

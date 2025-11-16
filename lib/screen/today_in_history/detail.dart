import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:query_assistant_padi/screen/today_in_history/type.dart';

class TodayInHistodayDetailPage extends StatelessWidget {
  final TodayInHistodayType item;
  final String imageTag;
  final String subtitleTag;

  const TodayInHistodayDetailPage({super.key, required this.item, required this.imageTag, required this.subtitleTag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.cover.isNotEmpty)
            Hero(
              tag: imageTag,
              child: CachedNetworkImage(imageUrl: item.cover, height: 250, width: double.infinity, fit: BoxFit.cover),
            ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: item.cover.isEmpty ? ScreenUtil().statusBarHeight : 0),
                  Text(item.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Hero(
                    tag: subtitleTag,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(item.subtitle, style: const TextStyle(fontSize: 14)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

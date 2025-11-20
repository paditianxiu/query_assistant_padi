import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'controller.dart';

class BeautifulGirlVideoPage extends StatelessWidget {
  const BeautifulGirlVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BeautifulVideoController>(
      init: BeautifulVideoController(),
      builder: (c) {
        if (c.videos.isEmpty) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
          body: PageView.builder(
            controller: c.pageController,
            scrollDirection: Axis.vertical,
            itemCount: c.videos.length,
            itemBuilder: (context, index) {
              final v = c.videos[index];
              if (!v.value.isInitialized) {
                return const Center(child: CircularProgressIndicator());
              }
              return SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(width: v.value.size.width, height: v.value.size.height, child: VideoPlayer(v)),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

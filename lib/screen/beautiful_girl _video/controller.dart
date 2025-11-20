import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class BeautifulVideoController extends GetxController {
  final pageController = PageController();
  final videos = <VideoPlayerController>[].obs;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    loadNextVideo().then((_) => loadNextVideo());
    pageController.addListener(() {
      if (!pageController.hasClients) return;
      final p = pageController.page;
      if (p == null) return;
      final index = p.round();
      if (index < 0 || index >= videos.length) return;
      for (int i = 0; i < videos.length; i++) {
        if (i == index) {
          videos[i].play();
        } else {
          videos[i].pause();
        }
      }
      if (index >= videos.length - 1 && !isLoading) {
        loadNextVideo();
      }
    });
  }

  Future<void> loadNextVideo() async {
    if (isLoading) return;
    isLoading = true;
    final url = "https://v2.xxapi.cn/api/meinv?return=302";
    final c = VideoPlayerController.networkUrl(Uri.parse(url));
    await c.initialize();
    c.setLooping(false);
    c.addListener(() {
      if (!c.value.isInitialized) return;
      if (!pageController.hasClients) return;
      final i = videos.indexOf(c);
      final current = pageController.page?.round() ?? -1;
      if (i == current && c.value.position >= c.value.duration && !isLoading) {
        loadNextVideo().then((_) {
          if (i + 1 < videos.length) {
            pageController.animateToPage(i + 1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
          }
        });
      }
    });
    videos.add(c);
    if (videos.length == 1) {
      Future.delayed(const Duration(milliseconds: 80), () {
        videos.first.play();
      });
    }
    isLoading = false;
    update();
  }

  @override
  void onClose() {
    for (final v in videos) {
      v.dispose();
    }
    pageController.dispose();
    super.onClose();
  }
}

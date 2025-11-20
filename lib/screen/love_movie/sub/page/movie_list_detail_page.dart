import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:query_assistant_padi/screen/love_movie/controller.dart';

class MovieListDetailPage extends StatefulWidget {
  final String id;
  const MovieListDetailPage({super.key, required this.id});

  @override
  State<MovieListDetailPage> createState() => _MovieListDetailPageState();
}

class _MovieListDetailPageState extends State<MovieListDetailPage> {
  final LoveMovieController controller = Get.find<LoveMovieController>();

  final headers = {
    'User-Agent': 'Rexxar-Core/0.1.3 api-client/1 com.douban.frodo/7.112.0(337)',
    'authorization': 'Bearer 25ebb471a554053c71c31d54effc0fb4',
  };

  @override
  void initState() {
    super.initState();
    controller.doubanPlayListDetail.clear();
    controller.getDoubanPlayListDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("详情")),
      body: Obx(() {
        final list = controller.doubanPlayListDetail;

        if (list.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: list.length,
          itemBuilder: (_, index) {
            final item = list[index];
            final pageController = PageController();

            return Container(
              margin: const EdgeInsets.only(bottom: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: item.coverUrl,
                              httpHeaders: headers,
                              width: 130,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),

                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              width: 28,
                              height: 28,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                "${index + 1}",
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: SizedBox(
                          height: 180,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                PageView.builder(
                                  controller: pageController,
                                  itemCount: item.photos.length,
                                  itemBuilder: (_, i) {
                                    return CachedNetworkImage(
                                      imageUrl: item.photos[i],
                                      httpHeaders: headers,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),

                                Positioned(
                                  bottom: 8,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      item.photos.length,
                                      (dot) => AnimatedBuilder(
                                        animation: pageController,
                                        builder: (_, __) {
                                          double current = 0;
                                          if (pageController.hasClients) {
                                            current = pageController.page ?? 0;
                                          }

                                          bool active = (current.round() == dot);

                                          return Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 3),
                                            width: active ? 10 : 6,
                                            height: active ? 10 : 6,
                                            decoration: BoxDecoration(
                                              color: active ? Colors.white : Colors.white54,
                                              shape: BoxShape.circle,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Text(item.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite_border, color: Colors.orange[400], size: 26),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(item.cardSubtitle, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                  const SizedBox(height: 6),
                  Text(item.description, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                  if (index != list.length - 1) Divider(),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}

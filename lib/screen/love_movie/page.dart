import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:query_assistant_padi/screen/love_movie/controller.dart';

class LoveMoviePage extends StatelessWidget {
  final LoveMovieController controller = Get.put(LoveMovieController());

  LoveMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    double currentWidth = 0.0;
    return Scaffold(
      appBar: AppBar(title: const Text("爱搜片")),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          currentWidth = MediaQuery.of(context).size.width;
          return ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Obx(() {
              final subjects = controller.subjects;
              return subjects.isNotEmpty
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (currentWidth ~/ 130),
                        childAspectRatio: 0.6,
                      ),
                      itemCount: subjects.length,
                      itemBuilder: (context, index) {
                        return buildGridItem(
                          subjects[index].title,
                          subjects[index].cover,
                          subjects[index].rate,
                          true,
                          {},
                          index,
                        );
                      },
                    )
                  : const Center(child: CircularProgressIndicator());
            }),
          );
        },
      ),
    );
  }
}

buildGridItem(String title, String imgUrl, String time, bool canSearch, Map map, index) {
  return GestureDetector(
    onTap: () {
      if (canSearch) {
      } else {}
    },
    child: Card.outlined(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    httpHeaders: const {'User-Agent': 'PostmanRuntime/7.37.0'},
                    width: double.infinity,
                    height: 100,
                    imageUrl: imgUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(textAlign: TextAlign.center, title, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            time != ""
                ? Positioned(
                    left: 0,
                    top: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(95),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(50.0),
                          topRight: Radius.circular(50.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(time, style: const TextStyle(color: Colors.white, fontSize: 13)),
                      ),
                    ),
                  )
                : const Text(""),
          ],
        ),
      ),
    ),
  );
}

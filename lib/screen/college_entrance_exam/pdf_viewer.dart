import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key});

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  final pdf = Get.arguments;
  var page = 0.obs;
  var currentPage = 1.obs;
  var canScroll = false.obs;
  final TextEditingController controller = TextEditingController();
  final PageController pageController = PageController();
  @override
  void initState() {
    super.initState();
    getPageNum();
    controller.text = '1';
  }

  getPageNum() async {
    final res = await Dio().get('https://doc2.211699.xyz/pdf/info', queryParameters: {'name': pdf['url']});
    page.value = res.data;
  }

  pageSelect() {
    Get.dialog(
      AlertDialog(
        title: Text('跳转页面'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: controller,
              decoration: InputDecoration(
                hintText: '要跳转的页数',
                labelText: "页数",
                filled: true,
                prefixIcon: IconButton(
                  onPressed: () {
                    if (controller.text == '1') return;
                    final res = int.parse(controller.text) - 1;
                    controller.text = res.toString();
                  },
                  icon: Icon(Icons.remove),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    if (controller.text == page.value.toString()) return;
                    final res = int.parse(controller.text) + 1;
                    controller.text = res.toString();
                  },
                  icon: Icon(Icons.add),
                ),
                helperText: "最小1, 最大${page.value}",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('取消'),
          ),
          FilledButton(
            onPressed: () {
              int parsePage = int.parse(controller.text);
              if (parsePage >= 1 && parsePage <= page.value) {
                pageController.jumpToPage(parsePage - 1);
                Get.back();
              }
            },
            child: Text('跳转'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(width: double.infinity, child: AutoSizeText(pdf['name'], maxLines: 1)),
      ),
      body: Obx(
        () => Stack(
          children: [
            PageView.builder(
              controller: pageController,
              physics: canScroll.value ? ScrollPhysics() : NeverScrollableScrollPhysics(),
              onPageChanged: (value) {
                currentPage.value = value + 1;
                controller.text = currentPage.value.toString();
              },
              scrollDirection: Axis.vertical,
              itemCount: page.value,
              itemBuilder: (context, index) {
                return PhotoView(
                  imageProvider: CachedNetworkImageProvider(
                    'https://doc2.211699.xyz/pdf/page?name=${pdf['url']}&page=${index + 1}',
                  ),
                );
              },
            ),
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: () => pageSelect(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(60),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "${currentPage.value}/${page.value}",
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: Column(
                children: [
                  IconButton.filledTonal(
                    onPressed: () {
                      int parsePage = currentPage.value - 1;
                      if (parsePage >= 1) {
                        pageController.jumpToPage(parsePage - 1);
                      }
                    },
                    icon: Icon(Icons.arrow_upward_outlined),
                  ),
                  IconButton.filledTonal(
                    onPressed: () {
                      int parsePage = currentPage.value + 1;
                      if (parsePage <= page.value) {
                        pageController.jumpToPage(parsePage - 1);
                      }
                    },
                    icon: Icon(Icons.arrow_downward_outlined),
                  ),
                  canScroll.value
                      ? IconButton.filledTonal(
                          onPressed: () {
                            canScroll.value = false;
                          },
                          icon: Icon(Icons.push_pin_outlined),
                        )
                      : IconButton.filled(
                          onPressed: () {
                            canScroll.value = true;
                          },
                          icon: Icon(Icons.push_pin),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

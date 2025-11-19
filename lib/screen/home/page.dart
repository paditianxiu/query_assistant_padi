import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:query_assistant_padi/screen/home/controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(HomeController());
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Obx(() {
              return Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: CarouselSlider(
                      items: c.bannerList
                          .map(
                            (e) => ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                imageUrl: e,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                        onPageChanged: (index, reason) {
                          c.currentBanner.value = index;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => AnimatedSmoothIndicator(
                      activeIndex: c.currentBanner.value,
                      count: c.bannerList.length,
                      effect: ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        spacing: 8,
                        activeDotColor: Theme.of(context).colorScheme.primary,
                        dotColor: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 20)),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Obx(() {
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: c.tools.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (_, i) {
                    final item = c.tools[i];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {},
                          child: Ink(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(16),
                            ),

                            child: Center(
                              child: Icon(
                                item["icon"] as IconData,
                                size: 32,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 6),
                        Text(item["name"].toString(), style: const TextStyle(fontSize: 13)),
                      ],
                    );
                  },
                );
              }),
            ),
          ),

          const SliverPadding(padding: EdgeInsets.only(top: 20)),
        ],
      ),
    );
  }
}

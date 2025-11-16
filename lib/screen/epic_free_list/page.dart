import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:query_assistant_padi/screen/epic_free_list/controller.dart';
import 'package:query_assistant_padi/screen/epic_free_list/type.dart';
import 'package:query_assistant_padi/utils/url_utils.dart';

class EpicFreeListPage extends StatelessWidget {
  const EpicFreeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EpicFreeController());

    const crossAxisCount = 2; // 修改列数在这里

    return Scaffold(
      appBar: AppBar(title: const Text('Epic喜加一')),
      body: Obx(() {
        final games = controller.data;

        return MasonryGridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemCount: games.isEmpty ? crossAxisCount * 6 : games.length,
          itemBuilder: (context, index) {
            if (games.isEmpty) {
              return _SkeletonCard();
            }
            final g = games[index];
            final period = controller.formatPeriod(g.freeStartAt, g.freeEndAt);
            return _GameCard(game: g, period: period);
          },
        );
      }),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(12)),
      height: 260,
    );
  }
}

class _GameCard extends StatelessWidget {
  final Datum game;
  final String period;

  const _GameCard({required this.game, required this.period});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: game.cover,
                fit: BoxFit.cover,
                placeholder: (c, _) => const Center(child: CircularProgressIndicator()),
                errorWidget: (c, _, __) => const Center(child: Icon(Icons.broken_image)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          game.title,
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: game.isFreeNow ? Colors.green.shade600 : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          game.isFreeNow ? '免费中' : game.originalPriceDesc,
                          style: TextStyle(
                            color: game.isFreeNow ? Colors.white : Colors.black87,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(game.seller, style: theme.textTheme.bodySmall),
                  const SizedBox(height: 8),
                  Text(
                    game.description,
                    style: theme.textTheme.bodySmall,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade600),
                      const SizedBox(width: 6),
                      Expanded(child: Text(period, style: theme.textTheme.bodySmall)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () async {
                      await openLink(game.link);
                    },
                    child: const Text('去商店领取'),
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

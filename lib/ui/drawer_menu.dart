import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:query_assistant_padi/screen/tools/controller.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  final ToolsController controller = Get.find<ToolsController>();

  Widget buildItem(IconData icon, String title, int index) {
    final theme = Get.theme;

    return Obx(() {
      final bool active = controller.navIndex.value == index;

      return InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          if (index <= 3) {
            controller.changeNavIndex(index);
            Get.back();
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: active
              ? BoxDecoration(color: theme.colorScheme.primaryContainer, borderRadius: BorderRadius.circular(20))
              : null,
          child: Row(
            children: [
              Icon(icon, color: active ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurfaceVariant),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: active ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),
          buildItem(Icons.home_outlined, "软件首页", 0),
          const SizedBox(height: 10),
          buildItem(Icons.apps, "全部工具", 1),
          const SizedBox(height: 10),
          buildItem(Icons.inventory_2_outlined, "仓库合集", 2),
          const SizedBox(height: 10),
          buildItem(Icons.info_outline, "关于软件", 3),
          const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Divider()),
          buildItem(Icons.update, "更新日志", 4),
          const SizedBox(height: 10),
          buildItem(Icons.share_outlined, "分享软件", 5),
          const SizedBox(height: 10),
          buildItem(Icons.info_outline, "关于软件", 6),
          const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Divider()),
          buildItem(Icons.group_outlined, "官方交流群", 7),
        ],
      ),
    );
  }
}

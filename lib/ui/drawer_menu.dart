import 'package:flutter/material.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  int selected = 0;

  Widget buildItem(IconData icon, String title, int index) {
    bool active = selected == index;
    return InkWell(
      onTap: () => setState(() => selected = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: active
            ? BoxDecoration(color: const Color(0xFFD8E3EF), borderRadius: BorderRadius.circular(20))
            : null,
        child: Row(
          children: [
            Icon(icon, color: Colors.black87),
            const SizedBox(width: 16),
            Text(title, style: const TextStyle(fontSize: 16, color: Colors.black87)),
          ],
        ),
      ),
    );
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
          const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Divider()),
          buildItem(Icons.update, "更新日志", 3),
          const SizedBox(height: 10),
          buildItem(Icons.share_outlined, "分享软件", 4),
          const SizedBox(height: 10),
          buildItem(Icons.info_outline, "关于软件", 5),
          const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Divider()),

          buildItem(Icons.group_outlined, "官方交流群", 6),
        ],
      ),
    );
  }
}

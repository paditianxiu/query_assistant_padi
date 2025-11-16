import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:query_assistant_padi/controllers/home_controller.dart';
import 'package:query_assistant_padi/ui/drawer_menu.dart';
import 'package:query_assistant_padi/ui/gradient_card.dart';
import 'package:query_assistant_padi/ui/tool_group.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(
        title: const Text("查询助手"),
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () => _scaffoldKey.currentState!.openDrawer()),
      ),

      drawer: ClipRRect(
        borderRadius: const BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: Drawer(width: 280, child: const DrawerMenu()),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: const [
              Expanded(
                child: GradientCard(title: "我的收藏", subtitle: "收藏你喜欢的工具", icon: Icons.shopping_bag),
              ),
              SizedBox(width: 12),
              Expanded(
                child: GradientCard(title: "近期更新", subtitle: "最近更新的工具", icon: Icons.auto_awesome),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const ToolGroup(
            icon: Icons.wb_sunny_outlined,
            title: "生活日常",
            isFirst: true,
            tools: [
              "爱搜片",
              "历史上的今天",
              "壁纸大全",
              "指持弹幕",
              "指尖陀螺",
              "秒表",
              "计时器",
              "翻页时钟",
              "每日早报",
              "在线翻译",
              "每日一文",
              "随机美女视频",
              "记分板",
              "怀旧游戏",
            ],
          ),

          const SizedBox(height: 8),

          const ToolGroup(
            icon: Icons.settings_outlined,
            title: "系统操作",
            tools: ["APK提取", "系统界面调节", "字体调节", "屏幕坏点检测", "空文件夹清理", "设备信息", "声音清灰", "提取手机壁纸"],
          ),

          const SizedBox(height: 8),
          const ToolGroup(
            icon: Icons.apps_outlined,
            isLast: true,
            title: "黑客工具",
            tools: ["计算器", "进制转换", "二维码生成", "图片压缩", "图片转码", "图片去水印"],
          ),

          const SizedBox(height: 8),
        ],
      ),

      bottomNavigationBar: Obx(() {
        return NavigationBar(
          height: 70,
          selectedIndex: controller.navIndex.value,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          onDestinationSelected: controller.changeNavIndex,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: "首页"),
            NavigationDestination(icon: Icon(Icons.apps_outlined), selectedIcon: Icon(Icons.apps), label: "工具"),
            NavigationDestination(
              icon: Icon(Icons.inventory_2_outlined),
              selectedIcon: Icon(Icons.inventory_2),
              label: "仓库",
            ),
          ],
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:query_assistant_padi/controllers/theme_controller.dart';
import 'package:query_assistant_padi/dialog/theme_bottom_sheet.dart';
import 'package:query_assistant_padi/screen/home/page.dart';
import 'package:query_assistant_padi/screen/info/page.dart';
import 'package:query_assistant_padi/screen/pack/page.dart';
import 'package:query_assistant_padi/screen/tools/controller.dart';
import 'package:query_assistant_padi/screen/tools/page.dart';
import 'package:query_assistant_padi/ui/drawer_menu.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class App extends StatelessWidget {
  App({super.key});

  final HomeController controller = Get.put(HomeController());
  final ThemeController themeController = Get.put(ThemeController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("查询助手"),
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () => _scaffoldKey.currentState!.openDrawer()),
        actions: [
          IconButton(
            icon: const Icon(Icons.color_lens_outlined),
            onPressed: () => ThemeBottomSheet.show(themeController),
          ),
        ],
      ),
      drawer: ClipRRect(
        borderRadius: const BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: Drawer(width: 280, child: const DrawerMenu()),
      ),
      body: Obx(
        () => LazyLoadIndexedStack(
          index: controller.navIndex.value,
          children: const [HomePage(), ToolsPage(), PackPage(), InfoPage()],
        ),
      ),
      bottomNavigationBar: Obx(
        () => Material(
          color: themeController.isDarkMode.value ? Colors.black : Colors.white,
          elevation: 10,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: SalomonBottomBar(
            selectedItemColor: themeController.primaryColor.value,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            currentIndex: controller.navIndex.value,
            onTap: controller.changeNavIndex,
            items: [
              SalomonBottomBarItem(icon: Icon(Icons.home_outlined), title: Text("首页")),
              SalomonBottomBarItem(icon: Icon(Icons.apps_outlined), title: Text("工具箱")),
              SalomonBottomBarItem(icon: Icon(Icons.inventory_2_outlined), title: Text("仓库")),
              SalomonBottomBarItem(icon: Icon(Icons.info_outline), title: Text("关于")),
            ],
          ),
        ),
      ),
    );
  }
}

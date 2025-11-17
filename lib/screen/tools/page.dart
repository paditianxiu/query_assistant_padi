import 'package:flutter/material.dart';
import 'package:query_assistant_padi/ui/gradient_card.dart';
import 'package:query_assistant_padi/ui/tool_group.dart';

class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        const _TopCards(),
        const SizedBox(height: 20),
        const ToolGroup(
          icon: Icons.wb_sunny_outlined,
          title: "生活日常",
          isFirst: true,
          tools: [
            "爱搜片",
            "历史上的今天",
            "QQ头像获取",
            "二维码生成",
            "Epic喜加一",
            "壁纸大全",
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
      ],
    );
  }
}

// 顶部两个渐变卡片
class _TopCards extends StatelessWidget {
  const _TopCards();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: GradientCard(title: "我的收藏", subtitle: "收藏你喜欢的工具", icon: Icons.shopping_bag),
        ),
        SizedBox(width: 12),
        Expanded(
          child: GradientCard(title: "近期更新", subtitle: "最近更新的工具", icon: Icons.auto_awesome),
        ),
      ],
    );
  }
}

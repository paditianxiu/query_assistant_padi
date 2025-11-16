import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:query_assistant_padi/controllers/theme_controller.dart';
import 'package:query_assistant_padi/function/tool_on_tap.dart';

class ToolGroup extends StatefulWidget {
  final IconData icon;
  final String title;
  final List<String> tools;
  final bool isFirst;
  final bool isLast;

  const ToolGroup({
    super.key,
    required this.icon,
    required this.title,
    required this.tools,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  State<ToolGroup> createState() => _ToolGroupState();
}

class _ToolGroupState extends State<ToolGroup> with SingleTickerProviderStateMixin {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final theme = Theme.of(context);

    BorderRadiusGeometry borderRadius;
    if (widget.isFirst) {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      );
    } else if (widget.isLast) {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      );
    } else {
      borderRadius = BorderRadius.circular(8);
    }

    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: themeController.isDarkMode.value
              ? theme.colorScheme.surfaceContainerHighest
              : theme.colorScheme.surfaceContainerHigh,
          borderRadius: borderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Icon(widget.icon, color: theme.colorScheme.onPrimaryContainer),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
                      ),
                      Text("EveryDay Tool", style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text("${widget.tools.length} 个功能", style: TextStyle(color: theme.colorScheme.onPrimary)),
                  ),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(Icons.expand_more, color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            if (_expanded) const SizedBox(height: 15),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Wrap(
                spacing: 10,
                runSpacing: 4,
                children: widget.tools.map((t) => ToolTag(text: t)).toList(),
              ),
              crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      );
    });
  }
}

class ToolTag extends StatelessWidget {
  final String text;

  const ToolTag({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(text),
      onPressed: () {
        toolOnTap(text);
      },
    );
  }
}

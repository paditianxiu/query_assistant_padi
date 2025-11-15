import 'package:flutter/material.dart';
import 'package:query_assistant_padi/function/tool_on_tap.dart';

class ToolGroup extends StatelessWidget {
  final IconData icon;
  final String title;
  final int count;
  final List<String> tools;

  const ToolGroup({super.key, required this.icon, required this.title, required this.count, required this.tools});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: .7), borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.blue.shade100,
                child: Icon(icon, color: Colors.blue.shade700),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("EveryDay Tool", style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.blue.shade800, borderRadius: BorderRadius.circular(30)),
                child: Text("$count 个功能", style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),

          const SizedBox(height: 15),
          Wrap(spacing: 10, runSpacing: 4, children: tools.map((t) => ToolTag(text: t)).toList()),
        ],
      ),
    );
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:query_assistant_padi/controllers/theme_controller.dart';

class ThemeBottomSheet {
  static void show(ThemeController themeController) {
    Get.bottomSheet(
      Material(
        color: Get.theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text("主题设置", style: Get.theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),

              // 深色模式开关
              Obx(
                () => SwitchListTile(
                  value: themeController.isDarkMode.value,
                  onChanged: (_) => themeController.toggleTheme(),
                  title: Text("深色模式", style: Get.theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  activeThumbColor: Get.theme.colorScheme.primary,
                  contentPadding: EdgeInsets.zero,
                ),
              ),

              const SizedBox(height: 16),

              Text("主题颜色", style: Get.theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),

              // 主题颜色网格
              Obx(() {
                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: List.generate(themeController.colors.length, (index) {
                    final color = themeController.colors[index];
                    final isSelected = themeController.primaryColor.value == color;
                    return GestureDetector(
                      onTap: () => themeController.changeColor(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: isSelected ? Border.all(width: 3, color: Get.theme.colorScheme.onSurface) : null,
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: color.withValues(alpha: .5),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                      ),
                    );
                  }),
                );
              }),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      clipBehavior: Clip.antiAlias,
    );
  }
}

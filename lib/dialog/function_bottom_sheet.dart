import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

enum InputFieldType { text, number, multiline, password }

class BottomSheetItem {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;

  BottomSheetItem({required this.label, this.icon, required this.onTap});
}

class DialogService {
  DialogService._();

  static void showListSheet(BuildContext context, {required String title, required List<BottomSheetItem> items}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: false,
      builder: (_) => _ListBottomSheet(title: title, items: items),
    );
  }

  static void showInputSheet(
    BuildContext context, {
    required String title,
    required ValueChanged<String> onSubmit,
    InputFieldType type = InputFieldType.text,
    String? hintText,
    String? initialValue,
    VoidCallback? onCancel,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _InputBottomSheet(
        title: title,
        onSubmit: onSubmit,
        type: type,
        hintText: hintText,
        initialValue: initialValue,
        onCancel: onCancel,
      ),
    );
  }
}

class _ListBottomSheet extends StatelessWidget {
  final String title;
  final List<BottomSheetItem> items;

  const _ListBottomSheet({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const radius = Radius.circular(30);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: const BorderRadius.only(topLeft: radius, topRight: radius),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDragBar(theme),
              const SizedBox(height: 14),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              ),

              const SizedBox(height: 10),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (_, i) => _BottomSheetListTile(item: items[i]),
                separatorBuilder: (_, __) => const SizedBox(height: 6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDragBar(ThemeData theme) {
    return Container(
      width: 40,
      height: 5,
      decoration: BoxDecoration(color: theme.colorScheme.outlineVariant, borderRadius: BorderRadius.circular(50)),
    );
  }
}

class _InputBottomSheet extends StatelessWidget {
  final String title;
  final ValueChanged<String> onSubmit;
  final InputFieldType type;
  final String? hintText;
  final String? initialValue;
  final VoidCallback? onCancel;

  const _InputBottomSheet({
    required this.title,
    required this.onSubmit,
    required this.type,
    this.hintText,
    this.initialValue,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = TextEditingController(text: initialValue);
    const radius = Radius.circular(30);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHigh,
          borderRadius: const BorderRadius.only(topLeft: radius, topRight: radius),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDragBar(theme),
                const SizedBox(height: 14),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                ),

                const SizedBox(height: 14),
                _buildTextField(theme, controller),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: _btnStyle(),
                        onPressed: () {
                          Get.back();
                          onCancel?.call();
                        },
                        child: const Text("取消"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        style: _btnStyle(),
                        onPressed: () {
                          final text = controller.text.trim();
                          if (text.isNotEmpty) {
                            onSubmit(text);
                          }
                        },
                        child: const Text("确定"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDragBar(ThemeData theme) {
    return Container(
      width: 40,
      height: 5,
      decoration: BoxDecoration(color: theme.colorScheme.outlineVariant, borderRadius: BorderRadius.circular(50)),
    );
  }

  ButtonStyle _btnStyle() {
    return OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)));
  }

  Widget _buildTextField(ThemeData theme, TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: type == InputFieldType.password,
      keyboardType: _mapKeyboardType(),
      maxLines: type == InputFieldType.multiline ? null : 1,
      inputFormatters: _mapFormatters(),

      decoration: InputDecoration(
        filled: true,
        label: Text(hintText ?? "请输入内容"),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        fillColor: theme.colorScheme.surfaceContainerHighest,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  List<TextInputFormatter> _mapFormatters() {
    switch (type) {
      case InputFieldType.number:
        return [FilteringTextInputFormatter.digitsOnly];

      case InputFieldType.multiline:
      case InputFieldType.text:
      case InputFieldType.password:
        return [];
    }
  }

  TextInputType _mapKeyboardType() {
    switch (type) {
      case InputFieldType.number:
        return TextInputType.number;

      case InputFieldType.multiline:
        return TextInputType.multiline;

      case InputFieldType.password:
      case InputFieldType.text:
        return TextInputType.text;
    }
  }
}

class _BottomSheetListTile extends StatelessWidget {
  final BottomSheetItem item;

  const _BottomSheetListTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        item.onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Row(
          children: [
            if (item.icon != null)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item.icon, color: theme.colorScheme.onPrimaryContainer),
              ),
            if (item.icon != null) const SizedBox(width: 12),

            Expanded(
              child: Text(item.label, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500)),
            ),

            Icon(Icons.chevron_right, color: theme.colorScheme.outline),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:query_assistant_padi/screen/google_translate/controller.dart';

class GoogleTranslatePage extends StatefulWidget {
  const GoogleTranslatePage({super.key});

  @override
  State<GoogleTranslatePage> createState() => _GoogleTranslatePageState();
}

class _GoogleTranslatePageState extends State<GoogleTranslatePage> {
  late final TextEditingController _textController;
  late final FocusNode _textFocusNode;

  final googleTranslateController = Get.put(GoogleTranslateController());

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _textFocusNode = FocusNode();
    _textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    _textFocusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  void _performTranslation() {
    if (_textController.text.trim().isEmpty) return;
    googleTranslateController.translate(
      googleTranslateController.fromLanguage.value,
      googleTranslateController.toLanguage.value,
      _textController.text,
    );
  }

  void _swapLanguages() {
    final temp = googleTranslateController.fromLanguage.value;
    googleTranslateController.fromLanguage.value = googleTranslateController.toLanguage.value;
    googleTranslateController.toLanguage.value = temp;

    if (googleTranslateController.fromLanguage.value == 'auto') {
      googleTranslateController.fromLanguage.value = 'zh-CN';
    }

    _performTranslation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Google 翻译',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [_buildLanguageSelector(), _buildTranslationArea(), _buildAdditionalTranslations()]),
      ),
    );
  }

  Widget _buildLanguageSelector() {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colorScheme.outlineVariant, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => _buildLanguageDropdown(
                value: googleTranslateController.fromLanguage.value,
                onChanged: (value) {
                  googleTranslateController.fromLanguage.value = value!;
                  _performTranslation();
                },
                isSource: true,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),

            child: IconButton(
              onPressed: _swapLanguages,
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: colorScheme.primary..withValues(alpha: 0.3)),
                ),
                child: Icon(Icons.swap_horiz, color: colorScheme.primary, size: 20),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => _buildLanguageDropdown(
                value: googleTranslateController.toLanguage.value,
                onChanged: (value) {
                  googleTranslateController.toLanguage.value = value!;
                  _performTranslation();
                },
                isSource: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageDropdown({
    required String value,
    required ValueChanged<String?> onChanged,
    required bool isSource,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),

      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down, color: colorScheme.onSurface..withValues(alpha: 0.6)),
          items: [
            ...googleTranslateController.getLanguageMap().entries.map((entry) {
              return DropdownMenuItem(
                value: entry.key,
                child: Text(entry.value, style: TextStyle(fontSize: 14, color: colorScheme.onSurface)),
              );
            }),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildTranslationArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildInputArea(),
          const SizedBox(height: 16),
          _buildTranslateButton(),
          const SizedBox(height: 8),
          _buildOutputArea(),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    final colorScheme = Theme.of(context).colorScheme;
    return Card.outlined(
      color: colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Obx(
                  () => Text(
                    googleTranslateController.getLanguageMap()[googleTranslateController.fromLanguage.value] ?? '未知语言',
                    style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
                const Spacer(),
                if (_textController.text.isNotEmpty)
                  IconButton(
                    icon: Icon(Icons.clear, size: 18, color: colorScheme.onSurface.withValues(alpha: 0.5)),
                    onPressed: () {
                      _textController.clear();
                      googleTranslateController.clearResult();
                    },
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),

            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 100, maxHeight: 300),
              child: SingleChildScrollView(
                child: TextField(
                  controller: _textController,
                  focusNode: _textFocusNode,
                  maxLines: null,
                  style: TextStyle(fontSize: 16, height: 1.5, color: colorScheme.onSurface),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '输入要翻译的文本...',
                    hintStyle: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.4)),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildOutputArea() {
    return Obx(() {
      if (googleTranslateController.result.value.translated.isEmpty) {
        return _buildPlaceholder();
      }

      final colorScheme = Theme.of(context).colorScheme;
      return Card.outlined(
        color: colorScheme.surface,
        child: Container(
          constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Text(
                  googleTranslateController.result.value.translated,
                  style: TextStyle(fontSize: 16, height: 1.5, color: colorScheme.onSurface),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildPlaceholder() {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 120),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.translate, color: colorScheme.onSurface.withValues(alpha: 0.5), size: 32),
            const SizedBox(height: 8),
            Text('翻译结果将显示在这里', style: TextStyle(color: colorScheme.onSurface..withValues(alpha: 0.5), fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildTranslateButton() {
    final colorScheme = Theme.of(context).colorScheme;
    return Obx(() {
      final isTextEmpty = _textController.text.isEmpty;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: googleTranslateController.loading.value || isTextEmpty ? null : _performTranslation,
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 16),
              disabledBackgroundColor: colorScheme.primary.withValues(alpha: .3),
              disabledForegroundColor: colorScheme.onPrimary.withValues(alpha: .7),
            ),
            child: googleTranslateController.loading.value
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(colorScheme.onPrimary),
                    ),
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.translate, size: 20),
                      SizedBox(width: 8),
                      Text('翻译', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ],
                  ),
          ),
        ),
      );
    });
  }

  Widget _buildAdditionalTranslations() {
    final colorScheme = Theme.of(context).colorScheme;
    return Obx(() {
      if (googleTranslateController.result.value.entries.isEmpty) {
        return const SizedBox();
      }

      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Card.outlined(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.auto_awesome_mosaic, size: 18, color: colorScheme.primary),
                    const SizedBox(width: 8),
                    Text(
                      '其他翻译',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colorScheme.onSurface),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...googleTranslateController.result.value.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.pos,
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: entry.examples.map((example) {
                            return GestureDetector(
                              onTap: () {
                                _textController.text = example;
                                _performTranslation();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

                                decoration: BoxDecoration(
                                  color: colorScheme.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: colorScheme.primary.withValues(alpha: 0.3)),
                                ),
                                child: Text(
                                  example,
                                  style: TextStyle(
                                    color: colorScheme.primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      );
    });
  }
}

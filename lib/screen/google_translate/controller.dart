// ignore_for_file: equal_keys_in_map

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:query_assistant_padi/http/dio_instance.dart';
import 'package:query_assistant_padi/screen/google_translate/language.dart';
import 'package:query_assistant_padi/screen/google_translate/type.dart';

class GoogleTranslateController extends GetxController {
  final js = getJavascriptRuntime();

  final loading = false.obs;
  final result = TranslationResult(original: '', translated: '', entries: []).obs;
  var fromLanguage = 'auto'.obs;
  var toLanguage = 'en'.obs;
  final _url = "https://tr.iass.top/translate_a/single?";

  final String _jsCode = r'''
    function token(a) {
        var k = "";
        var b = 406644;
        var b1 = 3293161072;
        var jd = ".";
        var sb = "+-a^+6";
        var Zb = "+-3^+b+-f";
        for (var e = [], f = 0, g = 0; g < a.length; g++) {
            var m = a.charCodeAt(g);
            128 > m ? e[f++] = m: (2048 > m ? e[f++] = m >> 6 | 192 : (55296 == (m & 64512) && g + 1 < a.length && 56320 == (a.charCodeAt(g + 1) & 64512) ? (m = 65536 + ((m & 1023) << 10) + (a.charCodeAt(++g) & 1023), e[f++] = m >> 18 | 240, e[f++] = m >> 12 & 63 | 128) : e[f++] = m >> 12 | 224, e[f++] = m >> 6 & 63 | 128), e[f++] = m & 63 | 128)
        }
        a = b;
        for (f = 0; f < e.length; f++) a += e[f], a = RL(a, sb);
        a = RL(a, Zb);
        a ^= b1 || 0;
        0 > a && (a = (a & 2147483647) + 2147483648);
        a %= 1E6;
        return a.toString() + jd + (a ^ b)
    };

    function RL(a, b) {
        var t = "a";
        var Yb = "+";
        for (var c = 0; c < b.length - 2; c += 3) {
            var d = b.charAt(c + 2),
            d = d >= t ? d.charCodeAt(0) - 87 : Number(d),
            d = b.charAt(c + 1) == Yb ? a >>> d: a << d;
            a = b.charAt(c) == Yb ? a + d & 4294967295 : a ^ d ;
        }
        return a
    };
  ''';

  Future<String> _getTk(String text) async {
    js.evaluate(_jsCode);
    final tk = js.evaluate("token('$text')").stringResult;
    return tk;
  }

  Future<void> translate(String from, String to, String text) async {
    loading.value = true;
    final tk = await _getTk(text);
    final dtList = ["at", "bd", "ex", "ld", "md", "qca", "rw", "rm", "ss", "t"];
    final queryList = [
      "client=webapp",
      "sl=$from",
      "tl=$to",
      "hl=zh-CN",
      ...dtList.map((dt) => "dt=$dt"),
      "ie=UTF-8",
      "oe=UTF-8",
      "source=btn",
      "ssel=0",
      "tsel=0",
      "kc=0",
      "tk=$tk",
      "q=${Uri.encodeComponent(text)}",
    ];
    final q = queryList.join("&");

    final response = await DioInstance.instance().get(
      path: _url + q,
      options: Options(headers: {"User-Agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 4_0 like Mac OS X)"}),
    );

    result.value = _parseListResponse(response.data);
    loading.value = false;
  }

  Map<String, String> getLanguageMap() {
    return googleTranslateLanguage;
  }

  void clearResult() {
    result.value = TranslationResult(original: '', translated: '', entries: []);
  }

  TranslationResult _parseListResponse(List<dynamic> data) {
    String original = '';
    String translated = '';
    final entries = <WordEntry>[];

    if (data.isNotEmpty && data[0] is List) {
      final mainTranslation = data[0] as List;
      if (mainTranslation.isNotEmpty && mainTranslation[0] is List) {
        final translationParts = mainTranslation[0] as List;
        if (translationParts.length >= 2) {
          translated = translationParts[0]?.toString() ?? '';
          original = translationParts[1]?.toString() ?? '';
        }
      }
    }
    if (data.length > 1 && data[1] is List) {
      for (var posBlock in data[1] as List) {
        if (posBlock is List && posBlock.length >= 3) {
          final pos = posBlock[0]?.toString() ?? '';
          final words = <String>[];

          if (posBlock[2] is List) {
            for (var w in posBlock[2] as List) {
              if (w is List && w.isNotEmpty) {
                words.add(w[0]?.toString() ?? '');
              }
            }
          }

          if (words.isNotEmpty) {
            entries.add(WordEntry(pos: pos, examples: words));
          }
        }
      }
    }

    return TranslationResult(
      original: original.isNotEmpty ? original : '',
      translated: translated.isNotEmpty ? translated : '无法解析翻译结果',
      entries: entries,
    );
  }
}

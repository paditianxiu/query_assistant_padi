import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:query_assistant_padi/http/dio_instance.dart';
import 'package:query_assistant_padi/screen/today_in_history/type.dart';

class TodayInHistoryController extends GetxController {
  final url = "https://hao.360.com/histoday/${getTodayMMDD()}.html";

  var data = <TodayInHistodayType>[].obs;

  Future<void> fetchData() async {
    final res = await DioInstance.instance().getString(path: url);
    final document = parse(res);
    final items = document.querySelectorAll('.tih-list .tih-item');

    for (var item in items) {
      final title = cleanText(item.querySelector('dt')?.text).trim();
      final subtitle = item.querySelector('.clearfix .desc')?.text.trim() ?? "";
      final imgUrl = item.querySelector('dd .item-img')?.attributes["data-src"] ?? "";
      final link = item.querySelector('.right-btn-container a')?.attributes["href"] ?? "";
      data.add(TodayInHistodayType(title: title, subtitle: subtitle, url: link, cover: imgUrl));
    }
  }
}

String getTodayMMDD() {
  final now = DateTime.now();
  final month = now.month.toString().padLeft(2, '0');
  final day = now.day.toString().padLeft(2, '0');
  return "$month$day";
}

String cleanText(String? text) {
  return text?.replaceFirst(RegExp(r'^\d+\.\s*'), '') ?? "";
}

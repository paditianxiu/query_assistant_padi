import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:query_assistant_padi/http/dio_instance.dart';

class RandomEssayController extends GetxController {
  final content = "".obs;
  final title = "".obs;
  final author = "".obs;

  final url = "https://m.dushu.com/meiwen/random/";

  Future<void> getRandomEssay() async {
    clear();
    final html = await DioInstance.instance().getString(path: url);
    final doc = parse(html);
    final detail = doc.querySelector(".article-detail");
    if (detail != null) {
      content.value = detail.querySelector(".text")?.innerHtml ?? "";
      title.value = detail.querySelector("h1")?.text ?? "";
      author.value = detail.querySelector(".border-right")?.text ?? "";
    }
  }

  clear() {
    content.value = "";
    title.value = "";
    author.value = "";
  }
}

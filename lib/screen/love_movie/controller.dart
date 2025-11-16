import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:query_assistant_padi/http/dio_instance.dart';
import 'package:query_assistant_padi/screen/love_movie/hot_type.dart';
import 'package:query_assistant_padi/screen/love_movie/top250_type.dart';

class LoveMovieController extends GetxController {
  final hotUrl =
      "https://movie.douban.com/j/search_subjects?&type=movie&sort=recommend&tag=%E7%83%AD%E9%97%A8&page_limit=100&page_start=1";

  final top250Url = "https://movie.douban.com/top250";
  final laterUrl = "https://movie.douban.com/cinema/later/";

  var subjects = <Subject>[].obs;
  var top250Data = <Top250Type>[].obs;
  var laterData = <Top250Type>[].obs;

  Future<void> getHotData() async {
    final res = await DioInstance.instance().get(path: hotUrl);
    final json = DouBanHotType.fromJson(res.data);
    subjects.assignAll(json.subjects);
  }

  Future<void> getTop250Data() async {
    final res = await DioInstance.instance().getString(path: top250Url);
    var document = parse(res);
    var itemList = document.querySelectorAll('.grid_view .item');
    for (var item in itemList) {
      var title = item.querySelector('.info .hd span')?.text ?? "";
      var rate = item.querySelector('.info .bd .star .rating_num')?.text ?? "";
      var cover = item.querySelector('.pic img')?.attributes['src'] ?? "";
      top250Data.add(Top250Type(title: title, cover: cover, rate: rate));
    }
  }

  Future<void> getLaterData() async {
    final res = await DioInstance.instance().getString(path: laterUrl);
    var document = parse(res);
    var mod = document.querySelectorAll(".item");
    for (var element in mod) {
      var allContent = element.innerHtml;
      var allDocument = parse(allContent);
      var imgUrl = allDocument.querySelector("img")?.attributes["src"] ?? "";
      var title = allDocument.querySelector("h3")?.text.replaceAll("\n", "").replaceAll(" ", "") ?? "";
      var time = allDocument.querySelector(".dt")?.text ?? "";
      laterData.add(Top250Type(title: title, cover: imgUrl, rate: time));
    }
  }
}

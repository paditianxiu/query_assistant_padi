import 'package:get/get.dart';
import 'package:query_assistant_padi/http/dio_instance.dart';
import 'package:query_assistant_padi/screen/love_movie/hot_type.dart';

class LoveMovieController extends GetxController {
  final hotUrl =
      "https://movie.douban.com/j/search_subjects?&type=movie&sort=recommend&tag=%E7%83%AD%E9%97%A8&page_limit=100&page_start=1";

  var subjects = <Subject>[].obs;

  Future<void> getHotData() async {
    final res = await DioInstance.instance().get(path: hotUrl);
    final json = DouBanHotType.fromJson(res.data);
    subjects.assignAll(json.subjects);
  }

  @override
  void onInit() {
    super.onInit();
    getHotData();
  }
}

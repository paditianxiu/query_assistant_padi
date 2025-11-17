import 'package:get/get.dart';
import 'package:query_assistant_padi/http/dio_instance.dart';
import 'package:query_assistant_padi/screen/wallpaper_collection/type.dart';

class WallpaperCollectionController extends GetxController {
  final homeUrl = "https://service.picasso.adesk.com/v1/lightwp/category";
  var homeData = <Category>[].obs;

  Future<void> getHomeData() async {
    final res = await DioInstance.instance().get(path: homeUrl);
    homeData.assignAll(WallpaperCollectionType.fromJson(res.data).res.category);
  }
}

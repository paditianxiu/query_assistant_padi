import 'package:get/get.dart';
import 'package:query_assistant_padi/http/dio_instance.dart';
import 'package:query_assistant_padi/screen/wallpaper_collection/detail_type.dart';

class WallpaperCollectionDetailController extends GetxController {
  final String id;
  WallpaperCollectionDetailController(this.id);

  final url = "https://service.picasso.adesk.com/v1/vertical/category";
  var list = <Vertical>[].obs;

  var page = 0;
  final limit = 30;
  var isLoading = false.obs;
  var noMore = false.obs;
  @override
  void onInit() {
    super.onInit();
    page = 0;
  }

  Future<void> refreshData() async {
    page = 0;
    noMore.value = false;
    final res = await DioInstance.instance().get(
      path: "$url/$id/vertical",
      param: {"limit": limit, "skip": page * limit, "order": "new"},
    );
    list.assignAll(WallpaperCollectionDetailType.fromJson(res.data).res.vertical);
  }

  Future<void> loadMore() async {
    if (isLoading.value || noMore.value) return;
    isLoading.value = true;

    page++;
    final res = await DioInstance.instance().get(
      path: "$url/$id/vertical",
      param: {"limit": limit, "skip": page * limit, "order": "new"},
    );
    final data = WallpaperCollectionDetailType.fromJson(res.data).res.vertical;

    if (data.isEmpty) {
      noMore.value = true;
    } else {
      list.addAll(data);
    }
    isLoading.value = false;
  }
}

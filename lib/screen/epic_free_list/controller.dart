import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:query_assistant_padi/http/dio_instance.dart';
import 'package:query_assistant_padi/screen/epic_free_list/type.dart';

class EpicFreeController extends GetxController {
  final url = "https://60s.viki.moe/v2/epic";
  var data = <Datum>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    final res = await DioInstance.instance().get(path: url);
    data.assignAll(EpicGameType.fromJson(res.data).data);
  }

  String formatPeriod(int startMs, int endMs) {
    if (startMs <= 0 || endMs <= 0) return '未知时间';

    final formatter = DateFormat('yyyy/MM/dd');

    final start = DateTime.fromMillisecondsSinceEpoch(startMs);
    final end = DateTime.fromMillisecondsSinceEpoch(endMs);

    return "${formatter.format(start)} - ${formatter.format(end)}";
  }
}

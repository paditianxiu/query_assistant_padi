import 'dart:convert';

import 'package:get/get.dart';
import 'package:query_assistant_padi/http/dio_instance.dart';
import 'package:query_assistant_padi/screen/epic_free_list/page.dart';
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

    String f(DateTime dt) =>
        "${dt.year.toString().padLeft(4, '0')}"
        "/${dt.month.toString().padLeft(2, '0')}"
        "/${dt.day.toString().padLeft(2, '0')}";

    final start = DateTime.fromMillisecondsSinceEpoch(startMs);
    final end = DateTime.fromMillisecondsSinceEpoch(endMs);

    return "${f(start)} - ${f(end)}";
  }
}

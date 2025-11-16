import 'package:get/get.dart';
import 'package:query_assistant_padi/screen/love_movie/page.dart';
import 'package:query_assistant_padi/screen/today_in_history/page.dart';

import 'package:query_assistant_padi/utils/toast_utils.dart';

void toolOnTap(String toolName) {
  switch (toolName) {
    case "爱搜片":
      Get.to(LoveMoviePage());
      break;
    case "历史上的今天":
      Get.to(TodayInHistoryPage());
      break;
    default:
      ToastUtils.showErrorMsg("功能开发中...");
  }
}

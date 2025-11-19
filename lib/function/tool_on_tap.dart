import 'package:get/get.dart';
import 'package:query_assistant_padi/dialog/function_bottom_sheet.dart';
import 'package:query_assistant_padi/screen/epic_free_list/page.dart';
import 'package:query_assistant_padi/screen/image_view_page.dart';
import 'package:query_assistant_padi/screen/love_movie/page.dart';
import 'package:query_assistant_padi/screen/today_in_history/page.dart';
import 'package:query_assistant_padi/screen/wallpaper_collection/page.dart';

import 'package:query_assistant_padi/utils/toast_utils.dart';

void toolOnTap(String toolName) {
  final context = Get.context;
  switch (toolName) {
    case "爱搜片":
      Get.to(LoveMoviePage());
      break;
    case "历史上的今天":
      Get.to(TodayInHistoryPage());
      break;
    case "QQ头像获取":
      DialogService.showInputSheet(
        context!,
        title: "QQ头像获取",
        hintText: "请输入需要查询的QQ号",
        type: InputFieldType.number,
        onSubmit: (qq) =>
            Get.to(ImageViewPage(imageUrl: "http://q.qlogo.cn/headimg_dl?dst_uin=$qq&spec=640&img_type=jpg")),
      );

      break;
    case "每日早报":
      Get.to(
        ImageViewPage(
          imageUrl: "https://60s.7se.cn/v2/60s?encoding=image-proxy&nocache=${DateTime.now().millisecondsSinceEpoch}",
        ),
      );
      break;
    case "二维码生成":
      DialogService.showInputSheet(
        context!,
        title: "二维码生成",
        hintText: "请输入需要链接或文本",
        type: InputFieldType.text,
        onSubmit: (value) => Get.to(ImageViewPage(imageUrl: "https://60s.7se.cn/v2/qrcode?text=$value")),
      );
      break;
    case "Epic喜加一":
      Get.to(EpicFreeListPage());
      break;
    case "壁纸大全":
      Get.to(WallpaperCollectionPage());
      break;
    default:
      ToastUtils.showErrorMsg("功能开发中...");
  }
}

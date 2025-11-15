import 'package:get/get.dart';
import 'package:query_assistant_padi/screen/love_movie/page.dart';

void toolOnTap(String toolName) {
  switch (toolName) {
    case "爱搜片":
      Get.to(LoveMoviePage());
      break;
  }
}

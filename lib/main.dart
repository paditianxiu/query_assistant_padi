import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:query_assistant_padi/controllers/theme_controller.dart';
import 'package:query_assistant_padi/app.dart';
import 'package:query_assistant_padi/http/dio_instance.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioInstance.instance().initDio();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (context, child) {
        return Obx(() {
          return GetMaterialApp(
            title: "查询助手",
            debugShowCheckedModeBanner: true,
            theme: ThemeData(
              brightness: Brightness.light,
              colorSchemeSeed: themeController.primaryColor.value,
              useMaterial3: true,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              colorSchemeSeed: themeController.primaryColor.value,
              useMaterial3: true,
            ),
            themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
            home: App(),
          );
        });
      },
    );
  }
}

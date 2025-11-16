import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:query_assistant_padi/screen/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: "查询助手",
          debugShowCheckedModeBanner: true,
          theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
          home: HomePage(),
        );
      },
    );
  }
}

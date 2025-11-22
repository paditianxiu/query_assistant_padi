import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:query_assistant_padi/screen/college_entrance_exam/pdf_viewer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CollegeEntranceExamPage extends StatefulWidget {
  const CollegeEntranceExamPage({super.key});

  @override
  State<CollegeEntranceExamPage> createState() => _CollegeEntranceExamPageState();
}

class _CollegeEntranceExamPageState extends State<CollegeEntranceExamPage> {
  var pdfs = [].obs;
  var isLoading = true.obs;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  refresh() async {
    try {
      isLoading.value = true;
      final res = await Dio().get("https://doc2.211699.xyz/pdf/list");
      pdfs.value = res.data;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("高考必刷题")),
      body: MyList(pdfs: pdfs, isLoading: isLoading),
    );
  }
}

class MyList extends StatelessWidget {
  const MyList({super.key, required this.pdfs, required this.isLoading});

  final RxList pdfs;
  final RxBool isLoading;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (isLoading.value) {
        return Skeletonizer(
          effect: ShimmerEffect(),
          enabled: true,
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return const ListTile(title: Text('这是一个骨架文本示例'), leading: Icon(Icons.book_outlined));
            },
          ),
        );
      }

      return ListView.builder(
        itemCount: pdfs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pdfs[index]['name']),
            leading: Icon(Icons.book_outlined),
            onTap: () {
              Get.to(() => PdfViewer(), arguments: pdfs[index]);
            },
          );
        },
      );
    });
  }
}

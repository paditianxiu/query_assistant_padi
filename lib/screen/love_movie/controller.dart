import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:query_assistant_padi/http/dio_instance.dart';
import 'package:query_assistant_padi/screen/love_movie/sub/type/douban_play_list_detail_type.dart';
import 'package:query_assistant_padi/screen/love_movie/sub/type/douban_play_list_type.dart';
import 'package:query_assistant_padi/screen/love_movie/sub/type/hot_type.dart';
import 'package:query_assistant_padi/screen/love_movie/sub/type/top250_type.dart';

class LoveMovieController extends GetxController {
  final hotUrl =
      "https://movie.douban.com/j/search_subjects?&type=movie&sort=recommend&tag=%E7%83%AD%E9%97%A8&page_limit=100&page_start=1";
  final top250Url = "https://movie.douban.com/top250";
  final laterUrl = "https://movie.douban.com/cinema/later/";
  final doubanPlayListUrl = "https://frodo.douban.com/api/v2/skynet/new_playlists";

  final subjects = <Subject>[].obs;
  final top250Data = <Top250Type>[].obs;
  final laterData = <Top250Type>[].obs;
  final doubanPlayLists = <PlaylistTypeItem>[].obs;
  final doubanPlayListDetail = <SubjectCollectionItem>[].obs;
  final navIndex = 0.obs;

  void changeNavIndex(int i) => navIndex.value = i;

  Future<void> getHotData() async {
    final res = await DioInstance.instance().get(path: hotUrl);
    final json = DouBanHotType.fromJson(res.data);
    subjects.assignAll(json.subjects);
  }

  Future<void> getTop250Data() async {
    final res = await DioInstance.instance().getString(path: top250Url);
    var document = parse(res);
    var itemList = document.querySelectorAll('.grid_view .item');
    top250Data.clear();
    for (var item in itemList) {
      var title = item.querySelector('.info .hd span')?.text ?? "";
      var rate = item.querySelector('.info .bd .star .rating_num')?.text ?? "";
      var cover = item.querySelector('.pic img')?.attributes['src'] ?? "";
      top250Data.add(Top250Type(title: title, cover: cover, rate: rate));
    }
  }

  Future<void> getLaterData() async {
    final res = await DioInstance.instance().getString(path: laterUrl);
    var document = parse(res);
    var mod = document.querySelectorAll(".item");
    laterData.clear();
    for (var element in mod) {
      var allContent = element.innerHtml;
      var allDocument = parse(allContent);
      var imgUrl = allDocument.querySelector("img")?.attributes["src"] ?? "";
      var title = allDocument.querySelector("h3")?.text.replaceAll("\n", "").replaceAll(" ", "") ?? "";
      var time = allDocument.querySelector(".dt")?.text ?? "";
      laterData.add(Top250Type(title: title, cover: imgUrl, rate: time));
    }
  }

  String hmacSha1(String key, String data) {
    final keyBytes = utf8.encode(key);
    final dataBytes = utf8.encode(data);
    final h = Hmac(sha1, keyBytes);
    final digest = h.convert(dataBytes);
    return base64Encode(digest.bytes);
  }

  Future<void> getDoubanPlayList() async {
    final ts = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    final sig = hmacSha1(
      'bf7dddc7c9cfe6f7',
      'GET&%2Fapi%2Fv2%2Fskynet%2Fnew_playlists&25ebb471a554053c71c31d54effc0fb4&$ts',
    );

    final params = {
      'category': 'all',
      'subject_type': 'movie',
      'start': '0',
      'count': '20',
      'udid': '7307ac14a094763e609fe3058d6fcabc41a502fd',
      'rom': 'miui6',
      'apikey': '0dad551ec0f84ed02907ff5c42e8ec70',
      's': 'rexxar_new',
      'channel': 'Xiaomi_Market',
      'timezone': 'Asia/Shanghai',
      'device_id': '7307ac14a094763e609fe3058d6fcabc41a502fd',
      'os_rom': 'miui6',
      'sugar': '0',
      'loc_id': '108288',
      '_sig': sig,
      '_ts': ts,
    };

    final headers = {
      'User-Agent':
          'Rexxar-Core/0.1.3 api-client/1 com.douban.frodo/7.112.0(337) Android/33 product/mondrian vendor/Xiaomi model/23013RK75C brand/Redmi  rom/miui6  network/wifi  udid/7307ac14a094763e609fe3058d6fcabc41a502fd  platform/mobile  foldable/0 nd/1 lt/2 com.douban.frodo/7.112.0(337) Rexxar/1.2.151  platform/mobile 1.2.151',
      'authorization': 'Bearer 25ebb471a554053c71c31d54effc0fb4',
    };

    final res = await DioInstance.instance().get(
      path: doubanPlayListUrl,
      param: params,
      options: Options(headers: headers),
    );
    final parsed = DoubanPlayListType.fromJson(res.data).data;

    doubanPlayLists.assignAll(parsed.expand((e) => e.items));
  }

  Future<void> getDoubanPlayListDetail(String id) async {
    final doubanPlayListDetailUrl = "https://frodo.douban.com/api/v2/subject_collection/$id/items";
    final ts = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    final sig = hmacSha1(
      'bf7dddc7c9cfe6f7',
      'GET&%2Fapi%2Fv2%2Fsubject_collection%2F$id%2Fitems&25ebb471a554053c71c31d54effc0fb4&$ts',
    );

    final params = {
      'start': "0",
      'count': "10",
      'updated_at': "",
      'items_only': "1",
      'type_tag': "",
      'udid': "7307ac14a094763e609fe3058d6fcabc41a502fd",
      'rom': "miui6",
      'apikey': "0dad551ec0f84ed02907ff5c42e8ec70",
      's': "rexxar_new",
      'channel': "Xiaomi_Market",
      'timezone': "Asia/Shanghai",
      'device_id': "7307ac14a094763e609fe3058d6fcabc41a502fd",
      'os_rom': "miui6",
      'sugar': "0",
      'loc_id': "108288",
      '_sig': sig,
      '_ts': ts,
    };

    final headers = {
      'User-Agent':
          'Rexxar-Core/0.1.3 api-client/1 com.douban.frodo/7.112.0(337) Android/33 product/mondrian vendor/Xiaomi model/23013RK75C brand/Redmi  rom/miui6  network/wifi  udid/7307ac14a094763e609fe3058d6fcabc41a502fd  platform/mobile  foldable/0 nd/1 lt/2 com.douban.frodo/7.112.0(337) Rexxar/1.2.151  platform/mobile 1.2.151',
      'authorization': 'Bearer 25ebb471a554053c71c31d54effc0fb4',
    };
    final res = await DioInstance.instance().get(
      path: doubanPlayListDetailUrl,
      param: params,
      options: Options(headers: headers),
    );
    doubanPlayListDetail.assignAll(DoubanPlayListDetailType.fromJson(res.data).subjectCollectionItems);
  }
}

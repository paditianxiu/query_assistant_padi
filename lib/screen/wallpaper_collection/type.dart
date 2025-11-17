import 'dart:convert';

WallpaperCollectionType wallpaperCollectionTypeFromJson(String str) =>
    WallpaperCollectionType.fromJson(json.decode(str));

String wallpaperCollectionTypeToJson(WallpaperCollectionType data) => json.encode(data.toJson());

class WallpaperCollectionType {
  String msg;
  Res res;
  int code;

  WallpaperCollectionType({required this.msg, required this.res, required this.code});

  factory WallpaperCollectionType.fromJson(Map<String, dynamic> json) =>
      WallpaperCollectionType(msg: json["msg"], res: Res.fromJson(json["res"]), code: json["code"]);

  Map<String, dynamic> toJson() => {"msg": msg, "res": res.toJson(), "code": code};
}

class Res {
  List<Category> category;

  Res({required this.category});

  factory Res.fromJson(Map<String, dynamic> json) =>
      Res(category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))));

  Map<String, dynamic> toJson() => {"category": List<dynamic>.from(category.map((x) => x.toJson()))};
}

class Category {
  int count;
  String ename;
  String rname;
  String coverTemp;
  String name;
  String cover;
  int rank;
  List<dynamic> filter;
  int sn;
  String icover;
  double? atime;
  int type;
  String id;
  String picassoCover;

  Category({
    required this.count,
    required this.ename,
    required this.rname,
    required this.coverTemp,
    required this.name,
    required this.cover,
    required this.rank,
    required this.filter,
    required this.sn,
    required this.icover,
    this.atime,
    required this.type,
    required this.id,
    required this.picassoCover,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    count: json["count"],
    ename: json["ename"],
    rname: json["rname"],
    coverTemp: json["cover_temp"],
    name: json["name"],
    cover: json["cover"],
    rank: json["rank"],
    filter: List<dynamic>.from(json["filter"].map((x) => x)),
    sn: json["sn"],
    icover: json["icover"],
    atime: json["atime"],
    type: json["type"],
    id: json["id"],
    picassoCover: json["picasso_cover"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "ename": ename,
    "rname": rname,
    "cover_temp": coverTemp,
    "name": name,
    "cover": cover,
    "rank": rank,
    "filter": List<dynamic>.from(filter.map((x) => x)),
    "sn": sn,
    "icover": icover,
    "atime": atime,
    "type": type,
    "id": id,
    "picasso_cover": picassoCover,
  };

  factory Category.empty() {
    return Category(
      name: '',
      cover: '',
      count: 0,
      ename: '',
      rname: '',
      coverTemp: '',
      rank: 0,
      filter: const [],
      sn: 0,
      icover: '',
      type: 0,
      id: '',
      picassoCover: '',
    );
  }
}

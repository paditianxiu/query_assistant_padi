import 'dart:convert';

WallpaperCollectionDetailType wallpaperCollectionDetailTypeFromJson(String str) =>
    WallpaperCollectionDetailType.fromJson(json.decode(str));

String wallpaperCollectionDetailTypeToJson(WallpaperCollectionDetailType data) => json.encode(data.toJson());

class WallpaperCollectionDetailType {
  String msg;
  Res res;
  int code;

  WallpaperCollectionDetailType({required this.msg, required this.res, required this.code});

  factory WallpaperCollectionDetailType.fromJson(Map<String, dynamic> json) =>
      WallpaperCollectionDetailType(msg: json["msg"], res: Res.fromJson(json["res"]), code: json["code"]);

  Map<String, dynamic> toJson() => {"msg": msg, "res": res.toJson(), "code": code};
}

class Res {
  List<Vertical> vertical;

  Res({required this.vertical});

  factory Res.fromJson(Map<String, dynamic> json) =>
      Res(vertical: List<Vertical>.from(json["vertical"].map((x) => Vertical.fromJson(x))));

  Map<String, dynamic> toJson() => {"vertical": List<dynamic>.from(vertical.map((x) => x.toJson()))};
}

class Vertical {
  int views;
  int ncos;
  int rank;
  List<String> tag;
  String wp;
  bool xr;
  bool cr;
  int favs;
  double atime;
  String id;
  String desc;
  String thumb;
  String img;
  List<dynamic> url;
  String rule;
  String preview;

  Vertical({
    required this.views,
    required this.ncos,
    required this.rank,
    required this.tag,
    required this.wp,
    required this.xr,
    required this.cr,
    required this.favs,
    required this.atime,
    required this.id,
    required this.desc,
    required this.thumb,
    required this.img,

    required this.url,
    required this.rule,
    required this.preview,
  });

  factory Vertical.fromJson(Map<String, dynamic> json) => Vertical(
    views: json["views"],
    ncos: json["ncos"],
    rank: json["rank"],
    tag: List<String>.from(json["tag"].map((x) => x)),
    wp: json["wp"],
    xr: json["xr"],
    cr: json["cr"],
    favs: json["favs"],
    atime: json["atime"],
    id: json["id"],
    desc: json["desc"],
    thumb: json["thumb"],
    img: json["img"],

    url: List<dynamic>.from(json["url"].map((x) => x)),
    rule: json["rule"],
    preview: json["preview"],
  );

  Map<String, dynamic> toJson() => {
    "views": views,
    "ncos": ncos,
    "rank": rank,
    "tag": List<dynamic>.from(tag.map((x) => x)),
    "wp": wp,
    "xr": xr,
    "cr": cr,
    "favs": favs,
    "atime": atime,
    "id": id,
    "desc": desc,
    "thumb": thumb,
    "img": img,
    "url": List<dynamic>.from(url.map((x) => x)),
    "rule": rule,
    "preview": preview,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

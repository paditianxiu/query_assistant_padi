import 'dart:convert';

EpicGameType epicGameTypeFromJson(String str) => EpicGameType.fromJson(json.decode(str));

String epicGameTypeToJson(EpicGameType data) => json.encode(data.toJson());

class EpicGameType {
  int code;
  String message;
  List<Datum> data;

  EpicGameType({required this.code, required this.message, required this.data});

  factory EpicGameType.fromJson(Map<String, dynamic> json) => EpicGameType(
    code: json["code"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String title;
  String cover;
  int originalPrice;
  String originalPriceDesc;
  String description;
  String seller;
  bool isFreeNow;
  String freeStart;
  int freeStartAt;
  String freeEnd;
  int freeEndAt;
  String link;

  Datum({
    required this.id,
    required this.title,
    required this.cover,
    required this.originalPrice,
    required this.originalPriceDesc,
    required this.description,
    required this.seller,
    required this.isFreeNow,
    required this.freeStart,
    required this.freeStartAt,
    required this.freeEnd,
    required this.freeEndAt,
    required this.link,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    cover: json["cover"],
    originalPrice: json["original_price"],
    originalPriceDesc: json["original_price_desc"],
    description: json["description"],
    seller: json["seller"],
    isFreeNow: json["is_free_now"],
    freeStart: json["free_start"],
    freeStartAt: json["free_start_at"],
    freeEnd: json["free_end"],
    freeEndAt: json["free_end_at"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "cover": cover,
    "original_price": originalPrice,
    "original_price_desc": originalPriceDesc,
    "description": description,
    "seller": seller,
    "is_free_now": isFreeNow,
    "free_start": freeStart,
    "free_start_at": freeStartAt,
    "free_end": freeEnd,
    "free_end_at": freeEndAt,
    "link": link,
  };
}

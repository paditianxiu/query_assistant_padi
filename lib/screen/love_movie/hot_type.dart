import 'dart:convert';

DouBanHotType douBanHotTypeFromJson(String str) => DouBanHotType.fromJson(json.decode(str));

String douBanHotTypeToJson(DouBanHotType data) => json.encode(data.toJson());

class DouBanHotType {
  List<Subject> subjects;

  DouBanHotType({required this.subjects});

  factory DouBanHotType.fromJson(Map<String, dynamic> json) =>
      DouBanHotType(subjects: List<Subject>.from(json["subjects"].map((x) => Subject.fromJson(x))));

  Map<String, dynamic> toJson() => {"subjects": List<dynamic>.from(subjects.map((x) => x.toJson()))};
}

class Subject {
  String episodesInfo;
  String rate;
  int coverX;
  String title;
  String url;
  bool playable;
  String cover;
  String id;
  int coverY;
  bool isNew;

  Subject({
    required this.episodesInfo,
    required this.rate,
    required this.coverX,
    required this.title,
    required this.url,
    required this.playable,
    required this.cover,
    required this.id,
    required this.coverY,
    required this.isNew,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    episodesInfo: json["episodes_info"],
    rate: json["rate"],
    coverX: json["cover_x"],
    title: json["title"],
    url: json["url"],
    playable: json["playable"],
    cover: json["cover"],
    id: json["id"],
    coverY: json["cover_y"],
    isNew: json["is_new"],
  );

  Map<String, dynamic> toJson() => {
    "episodes_info": episodesInfo,
    "rate": rate,
    "cover_x": coverX,
    "title": title,
    "url": url,
    "playable": playable,
    "cover": cover,
    "id": id,
    "cover_y": coverY,
    "is_new": isNew,
  };
}

import 'dart:convert';

DoubanPlayListDetailType doubanPlayListDetailTypeFromJson(String str) =>
    DoubanPlayListDetailType.fromJson(json.decode(str));

String doubanPlayListDetailTypeToJson(DoubanPlayListDetailType data) => json.encode(data.toJson());

class DoubanPlayListDetailType {
  int count;
  SubjectCollection subjectCollection;
  List<SubjectCollectionItem> subjectCollectionItems;
  int total;
  int start;

  DoubanPlayListDetailType({
    required this.count,
    required this.subjectCollection,
    required this.subjectCollectionItems,
    required this.total,
    required this.start,
  });

  factory DoubanPlayListDetailType.fromJson(Map<String, dynamic> json) => DoubanPlayListDetailType(
    count: json["count"],
    subjectCollection: SubjectCollection.fromJson(json["subject_collection"]),
    subjectCollectionItems: List<SubjectCollectionItem>.from(
      json["subject_collection_items"].map((x) => SubjectCollectionItem.fromJson(x)),
    ),
    total: json["total"],
    start: json["start"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "subject_collection": subjectCollection.toJson(),
    "subject_collection_items": List<dynamic>.from(subjectCollectionItems.map((x) => x.toJson())),
    "total": total,
    "start": start,
  };
}

class SubjectCollection {
  SubjectCollection();

  factory SubjectCollection.fromJson(Map<String, dynamic> json) => SubjectCollection();

  Map<String, dynamic> toJson() => {};
}

class SubjectCollectionItem {
  String comment;
  Rating rating;
  String controversyReason;
  int rankValue;
  Pic pic;
  int rank;
  String uri;
  bool isShow;
  List<dynamic> vendorIcons;
  String cardSubtitle;
  String id;
  String title;
  bool hasLinewatch;
  bool isReleased;
  dynamic interest;
  ColorScheme colorScheme;
  Subtype type;
  String description;
  List<dynamic> tags;
  String coverUrl;
  List<String> photos;
  List<String> actions;
  String sharingUrl;
  String url;
  List<HonorInfo> honorInfos;
  int goodRatingStats;
  Subtype subtype;
  NullRatingReason nullRatingReason;

  SubjectCollectionItem({
    required this.comment,
    required this.rating,
    required this.controversyReason,
    required this.rankValue,
    required this.pic,
    required this.rank,
    required this.uri,
    required this.isShow,
    required this.vendorIcons,
    required this.cardSubtitle,
    required this.id,
    required this.title,
    required this.hasLinewatch,
    required this.isReleased,
    required this.interest,
    required this.colorScheme,
    required this.type,
    required this.description,
    required this.tags,
    required this.coverUrl,
    required this.photos,
    required this.actions,
    required this.sharingUrl,
    required this.url,
    required this.honorInfos,
    required this.goodRatingStats,
    required this.subtype,
    required this.nullRatingReason,
  });

  factory SubjectCollectionItem.fromJson(Map<String, dynamic> json) => SubjectCollectionItem(
    comment: json["comment"],
    rating: Rating.fromJson(json["rating"]),
    controversyReason: json["controversy_reason"],
    rankValue: json["rank_value"],
    pic: Pic.fromJson(json["pic"]),
    rank: json["rank"],
    uri: json["uri"],
    isShow: json["is_show"],
    vendorIcons: List<dynamic>.from(json["vendor_icons"].map((x) => x)),
    cardSubtitle: json["card_subtitle"],
    id: json["id"],
    title: json["title"],
    hasLinewatch: json["has_linewatch"],
    isReleased: json["is_released"],
    interest: json["interest"],
    colorScheme: ColorScheme.fromJson(json["color_scheme"]),
    type: subtypeValues.map[json["type"]]!,
    description: json["description"],
    tags: List<dynamic>.from(json["tags"].map((x) => x)),
    coverUrl: json["cover_url"],
    photos: List<String>.from(json["photos"].map((x) => x)),
    actions: List<String>.from(json["actions"].map((x) => x)),
    sharingUrl: json["sharing_url"],
    url: json["url"],
    honorInfos: List<HonorInfo>.from(json["honor_infos"].map((x) => HonorInfo.fromJson(x))),
    goodRatingStats: json["good_rating_stats"],
    subtype: subtypeValues.map[json["subtype"]]!,
    nullRatingReason: nullRatingReasonValues.map[json["null_rating_reason"]]!,
  );

  Map<String, dynamic> toJson() => {
    "comment": comment,
    "rating": rating.toJson(),
    "controversy_reason": controversyReason,
    "rank_value": rankValue,
    "pic": pic.toJson(),
    "rank": rank,
    "uri": uri,
    "is_show": isShow,
    "vendor_icons": List<dynamic>.from(vendorIcons.map((x) => x)),
    "card_subtitle": cardSubtitle,
    "id": id,
    "title": title,
    "has_linewatch": hasLinewatch,
    "is_released": isReleased,
    "interest": interest,
    "color_scheme": colorScheme.toJson(),
    "type": subtypeValues.reverse[type],
    "description": description,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "cover_url": coverUrl,
    "photos": List<dynamic>.from(photos.map((x) => x)),
    "actions": List<dynamic>.from(actions.map((x) => x)),
    "sharing_url": sharingUrl,
    "url": url,
    "honor_infos": List<dynamic>.from(honorInfos.map((x) => x.toJson())),
    "good_rating_stats": goodRatingStats,
    "subtype": subtypeValues.reverse[subtype],
    "null_rating_reason": nullRatingReasonValues.reverse[nullRatingReason],
  };
}

class ColorScheme {
  bool isDark;
  String primaryColorLight;
  List<double> baseColor;
  String secondaryColor;
  List<double> avgColor;
  String primaryColorDark;

  ColorScheme({
    required this.isDark,
    required this.primaryColorLight,
    required this.baseColor,
    required this.secondaryColor,
    required this.avgColor,
    required this.primaryColorDark,
  });

  factory ColorScheme.fromJson(Map<String, dynamic> json) => ColorScheme(
    isDark: json["is_dark"],
    primaryColorLight: json["primary_color_light"],
    baseColor: List<double>.from(json["_base_color"].map((x) => x?.toDouble())),
    secondaryColor: json["secondary_color"],
    avgColor: List<double>.from(json["_avg_color"].map((x) => x?.toDouble())),
    primaryColorDark: json["primary_color_dark"],
  );

  Map<String, dynamic> toJson() => {
    "is_dark": isDark,
    "primary_color_light": primaryColorLight,
    "_base_color": List<dynamic>.from(baseColor.map((x) => x)),
    "secondary_color": secondaryColor,
    "_avg_color": List<dynamic>.from(avgColor.map((x) => x)),
    "primary_color_dark": primaryColorDark,
  };
}

class HonorInfo {
  Subtype kind;
  String uri;
  int? rank;
  String title;

  HonorInfo({required this.kind, required this.uri, required this.rank, required this.title});

  factory HonorInfo.fromJson(Map<String, dynamic> json) =>
      HonorInfo(kind: subtypeValues.map[json["kind"]]!, uri: json["uri"], rank: json["rank"], title: json["title"]);

  Map<String, dynamic> toJson() => {"kind": subtypeValues.reverse[kind], "uri": uri, "rank": rank, "title": title};
}

enum Subtype { MOVIE }

final subtypeValues = EnumValues({"movie": Subtype.MOVIE});

enum NullRatingReason { EMPTY, NULL_RATING_REASON, PURPLE }

final nullRatingReasonValues = EnumValues({
  "尚未上映": NullRatingReason.EMPTY,
  "暂无评分": NullRatingReason.NULL_RATING_REASON,
  "": NullRatingReason.PURPLE,
});

class Pic {
  String large;
  String normal;

  Pic({required this.large, required this.normal});

  factory Pic.fromJson(Map<String, dynamic> json) => Pic(large: json["large"], normal: json["normal"]);

  Map<String, dynamic> toJson() => {"large": large, "normal": normal};
}

class Rating {
  int count;
  int max;
  double starCount;
  double value;

  Rating({required this.count, required this.max, required this.starCount, required this.value});

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    count: json["count"],
    max: json["max"],
    starCount: json["star_count"]?.toDouble(),
    value: json["value"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {"count": count, "max": max, "star_count": starCount, "value": value};
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

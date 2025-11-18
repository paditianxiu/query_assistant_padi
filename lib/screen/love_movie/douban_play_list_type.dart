// To parse this JSON data, do
//
//     final doubanPlaylistType = doubanPlaylistTypeFromJson(jsonString);

import 'dart:convert';

DoubanPlaylistType doubanPlaylistTypeFromJson(String str) => DoubanPlaylistType.fromJson(json.decode(str));

String doubanPlaylistTypeToJson(DoubanPlaylistType data) => json.encode(data.toJson());

class DoubanPlaylistType {
  int count;
  int start;
  int total;
  List<PlaylistTypeData> data;
  String sharingUrl;

  DoubanPlaylistType({
    required this.count,
    required this.start,
    required this.total,
    required this.data,
    required this.sharingUrl,
  });

  factory DoubanPlaylistType.fromJson(Map<String, dynamic> json) => DoubanPlaylistType(
    count: json["count"],
    start: json["start"],
    total: json["total"],
    data: List<PlaylistTypeData>.from(json["data"].map((x) => PlaylistTypeData.fromJson(x))),
    sharingUrl: json["sharing_url"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "start": start,
    "total": total,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "sharing_url": sharingUrl,
  };
}

class PlaylistTypeData {
  String category;
  List<PlaylistTypeItem> items;
  int total;

  PlaylistTypeData({required this.category, required this.items, required this.total});

  factory PlaylistTypeData.fromJson(Map<String, dynamic> json) => PlaylistTypeData(
    category: json["category"],
    items: List<PlaylistTypeItem>.from(json["items"].map((x) => PlaylistTypeItem.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "total": total,
  };
}

class PlaylistTypeItem {
  BackgroundColorScheme? backgroundColorScheme;
  int? total;
  String id;
  Category category;
  bool isMergedCover;
  String title;
  IconText iconText;
  int followersCount;
  String type;
  String? rankType;
  String coverUrl;
  String headerBgImage;
  int doneCount;
  int? subjectCount;
  int itemsCount;
  String sharingUrl;
  int? collectCount;
  String url;
  bool? isBadgeChart;
  String uri;
  Category itemType;
  bool? finishSoon;
  ListType listType;
  bool? isFollow;
  Owner? owner;
  bool? isSubjectSelection;
  AlgJson? algJson;
  dynamic syncingNote;
  String? doulistType;

  PlaylistTypeItem({
    required this.backgroundColorScheme,
    this.total,
    required this.id,
    required this.category,
    required this.isMergedCover,
    required this.title,
    required this.iconText,
    required this.followersCount,
    required this.type,
    this.rankType,
    required this.coverUrl,
    required this.headerBgImage,
    required this.doneCount,
    this.subjectCount,
    required this.itemsCount,
    required this.sharingUrl,
    this.collectCount,
    required this.url,
    this.isBadgeChart,
    required this.uri,
    required this.itemType,
    this.finishSoon,
    required this.listType,
    this.isFollow,
    this.owner,
    this.isSubjectSelection,
    this.algJson,
    this.syncingNote,
    this.doulistType,
  });

  factory PlaylistTypeItem.fromJson(Map<String, dynamic> json) => PlaylistTypeItem(
    backgroundColorScheme: json["background_color_scheme"] == null
        ? null
        : BackgroundColorScheme.fromJson(json["background_color_scheme"]),
    total: json["total"],
    id: json["id"],
    category: categoryValues.map[json["category"]]!,
    isMergedCover: json["is_merged_cover"],
    title: json["title"],
    iconText: iconTextValues.map[json["icon_text"]]!,
    followersCount: json["followers_count"],
    type: json["type"],
    rankType: json["rank_type"],
    coverUrl: json["cover_url"],
    headerBgImage: json["header_bg_image"],
    doneCount: json["done_count"],
    subjectCount: json["subject_count"],
    itemsCount: json["items_count"],
    sharingUrl: json["sharing_url"],
    collectCount: json["collect_count"],
    url: json["url"],
    isBadgeChart: json["is_badge_chart"],
    uri: json["uri"],
    itemType: categoryValues.map[json["item_type"]]!,
    finishSoon: json["finish_soon"],
    listType: listTypeValues.map[json["list_type"]]!,
    isFollow: json["is_follow"],
    owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
    isSubjectSelection: json["is_subject_selection"],
    algJson: json["alg_json"] == null ? null : algJsonValues.map[json["alg_json"]]!,
    syncingNote: json["syncing_note"],
    doulistType: json["doulist_type"],
  );

  Map<String, dynamic> toJson() => {
    "background_color_scheme": backgroundColorScheme?.toJson(),
    "total": total,
    "id": id,
    "category": categoryValues.reverse[category],
    "is_merged_cover": isMergedCover,
    "title": title,
    "icon_text": iconTextValues.reverse[iconText],
    "followers_count": followersCount,
    "type": type,
    "rank_type": rankType,
    "cover_url": coverUrl,
    "header_bg_image": headerBgImage,
    "done_count": doneCount,
    "subject_count": subjectCount,
    "items_count": itemsCount,
    "sharing_url": sharingUrl,
    "collect_count": collectCount,
    "url": url,
    "is_badge_chart": isBadgeChart,
    "uri": uri,
    "item_type": categoryValues.reverse[itemType],
    "finish_soon": finishSoon,
    "list_type": listTypeValues.reverse[listType],
    "is_follow": isFollow,
    "owner": owner?.toJson(),
    "is_subject_selection": isSubjectSelection,
    "alg_json": algJsonValues.reverse[algJson],
    "syncing_note": syncingNote,
    "doulist_type": doulistType,
  };
}

enum AlgJson { EMPTY }

final algJsonValues = EnumValues({"{}": AlgJson.EMPTY});

class BackgroundColorScheme {
  bool isDark;
  String primaryColorLight;
  String secondaryColor;
  String primaryColorDark;

  BackgroundColorScheme({
    required this.isDark,
    required this.primaryColorLight,
    required this.secondaryColor,
    required this.primaryColorDark,
  });

  factory BackgroundColorScheme.fromJson(Map<String, dynamic> json) => BackgroundColorScheme(
    isDark: json["is_dark"],
    primaryColorLight: json["primary_color_light"],
    secondaryColor: json["secondary_color"],
    primaryColorDark: json["primary_color_dark"],
  );

  Map<String, dynamic> toJson() => {
    "is_dark": isDark,
    "primary_color_light": primaryColorLight,
    "secondary_color": secondaryColor,
    "primary_color_dark": primaryColorDark,
  };
}

enum Category { COMMON, MOVIE }

final categoryValues = EnumValues({"common": Category.COMMON, "movie": Category.MOVIE});

enum IconText { EMPTY, ICON_TEXT }

final iconTextValues = EnumValues({"片单": IconText.EMPTY, "": IconText.ICON_TEXT});

enum ListType { OFFICIAL_DOULIST, RANK_LIST, UGC_DOULIST }

final listTypeValues = EnumValues({
  "official_doulist": ListType.OFFICIAL_DOULIST,
  "rank_list": ListType.RANK_LIST,
  "ugc_doulist": ListType.UGC_DOULIST,
});

class Owner {
  Kind kind;
  String name;
  String url;
  String uri;
  String avatar;
  bool isClub;
  Kind type;
  String id;
  String uid;

  Owner({
    required this.kind,
    required this.name,
    required this.url,
    required this.uri,
    required this.avatar,
    required this.isClub,
    required this.type,
    required this.id,
    required this.uid,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    kind: kindValues.map[json["kind"]]!,
    name: json["name"],
    url: json["url"],
    uri: json["uri"],
    avatar: json["avatar"],
    isClub: json["is_club"],
    type: kindValues.map[json["type"]]!,
    id: json["id"],
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "kind": kindValues.reverse[kind],
    "name": name,
    "url": url,
    "uri": uri,
    "avatar": avatar,
    "is_club": isClub,
    "type": kindValues.reverse[type],
    "id": id,
    "uid": uid,
  };
}

enum Kind { USER }

final kindValues = EnumValues({"user": Kind.USER});

enum Type { CHART, PLAYLIST }

final typeValues = EnumValues({"chart": Type.CHART, "playlist": Type.PLAYLIST});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

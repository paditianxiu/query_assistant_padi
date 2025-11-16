// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TodayInHistodayType {
  String title;
  String subtitle;
  String url;
  String cover;
  TodayInHistodayType({required this.title, required this.subtitle, required this.url, required this.cover});

  TodayInHistodayType copyWith({String? title, String? subtitle, String? url, String? cover}) {
    return TodayInHistodayType(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      url: url ?? this.url,
      cover: cover ?? this.cover,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'title': title, 'subtitle': subtitle, 'url': url, 'cover': cover};
  }

  factory TodayInHistodayType.fromMap(Map<String, dynamic> map) {
    return TodayInHistodayType(
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      url: map['url'] as String,
      cover: map['cover'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodayInHistodayType.fromJson(String source) =>
      TodayInHistodayType.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TodayInHistodayType(title: $title, subtitle: $subtitle, url: $url, cover: $cover)';
  }

  @override
  bool operator ==(covariant TodayInHistodayType other) {
    if (identical(this, other)) return true;

    return other.title == title && other.subtitle == subtitle && other.url == url && other.cover == cover;
  }

  @override
  int get hashCode {
    return title.hashCode ^ subtitle.hashCode ^ url.hashCode ^ cover.hashCode;
  }
}

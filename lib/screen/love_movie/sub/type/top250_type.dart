// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Top250Type {
  final String title;
  final String cover;
  final String rate;
  Top250Type({required this.title, required this.cover, required this.rate});

  Top250Type copyWith({String? title, String? cover, String? rate}) {
    return Top250Type(title: title ?? this.title, cover: cover ?? this.cover, rate: rate ?? this.rate);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'title': title, 'cover': cover, 'rate': rate};
  }

  factory Top250Type.fromMap(Map<String, dynamic> map) {
    return Top250Type(title: map['title'] as String, cover: map['cover'] as String, rate: map['rate'] as String);
  }

  String toJson() => json.encode(toMap());

  factory Top250Type.fromJson(String source) => Top250Type.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Top250Type(title: $title, cover: $cover, rate: $rate)';

  @override
  bool operator ==(covariant Top250Type other) {
    if (identical(this, other)) return true;

    return other.title == title && other.cover == cover && other.rate == rate;
  }

  @override
  int get hashCode => title.hashCode ^ cover.hashCode ^ rate.hashCode;
}

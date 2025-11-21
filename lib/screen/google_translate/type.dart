// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class WordEntry {
  String pos; // 词性，如 动词、名词
  List<String> examples; // 例句或同义词
  WordEntry({required this.pos, required this.examples});

  WordEntry copyWith({String? pos, List<String>? examples}) {
    return WordEntry(pos: pos ?? this.pos, examples: examples ?? this.examples);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'pos': pos, 'examples': examples};
  }

  factory WordEntry.fromMap(Map<String, dynamic> map) {
    return WordEntry(pos: map['pos'] as String, examples: List<String>.from((map['examples'] as List<String>)));
  }

  String toJson() => json.encode(toMap());

  factory WordEntry.fromJson(String source) => WordEntry.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WordEntry(pos: $pos, examples: $examples)';

  @override
  bool operator ==(covariant WordEntry other) {
    if (identical(this, other)) return true;

    return other.pos == pos && listEquals(other.examples, examples);
  }

  @override
  int get hashCode => pos.hashCode ^ examples.hashCode;
}

class TranslationResult {
  String original; // 原文
  String translated; // 翻译
  List<WordEntry> entries;
  TranslationResult({required this.original, required this.translated, required this.entries});

  TranslationResult copyWith({String? original, String? translated, List<WordEntry>? entries}) {
    return TranslationResult(
      original: original ?? this.original,
      translated: translated ?? this.translated,
      entries: entries ?? this.entries,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'original': original,
      'translated': translated,
      'entries': entries.map((x) => x.toMap()).toList(),
    };
  }

  factory TranslationResult.fromMap(Map<String, dynamic> map) {
    return TranslationResult(
      original: map['original'] as String,
      translated: map['translated'] as String,
      entries: List<WordEntry>.from(
        (map['entries'] as List<int>).map<WordEntry>((x) => WordEntry.fromMap(x as Map<String, dynamic>)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TranslationResult.fromJson(String source) =>
      TranslationResult.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TranslationResult(original: $original, translated: $translated, entries: $entries)';

  @override
  bool operator ==(covariant TranslationResult other) {
    if (identical(this, other)) return true;

    return other.original == original && other.translated == translated && listEquals(other.entries, entries);
  }

  @override
  int get hashCode => original.hashCode ^ translated.hashCode ^ entries.hashCode;
}

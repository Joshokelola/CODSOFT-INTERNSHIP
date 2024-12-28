import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quote.g.dart';

@JsonSerializable()
class Quote extends HiveObject {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'content')
  final String text;

  final String author;

  final List<String>? tags;

  bool isFavorite;

  Quote({
    this.id,
    required this.text,
    required this.author,
    this.tags,
    this.isFavorite = false,
  });

  Quote copyWith({
    String? id,
    String? text,
    String? author,
    List<String>? tags,
    bool? isFavorite,
  }) {
    return Quote(
      id: id ?? this.id,
      text: text ?? this.text,
      author: author ?? this.author,
      tags: tags ?? this.tags,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteToJson(this);
}
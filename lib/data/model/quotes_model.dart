import 'package:json_annotation/json_annotation.dart';

part 'quotes_model.g.dart';

@JsonSerializable()
class Quote {
  Quote({
    required this.id,
    required this.quote,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

  final int id;
  final String quote;
  final String author;

  Map<String, dynamic> toJson() => _$QuoteToJson(this);
}

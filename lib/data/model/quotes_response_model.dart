import 'package:json_annotation/json_annotation.dart';
import './quotes_model.dart';

part 'quotes_response_model.g.dart';

@JsonSerializable()
class QuotesResponse {
  QuotesResponse({required this.quotes});

  factory QuotesResponse.fromJson(Map<String, dynamic> json) => _$QuotesResponseFromJson(json);

  final List<Quote> quotes;

  Map<String, dynamic> toJson() => _$QuotesResponseToJson(this);
}

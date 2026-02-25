import 'package:flutter_practice/core/app_imports.dart';

part 'carts_response.g.dart';

@JsonSerializable()
class CartsResponse {
  final List<Cart> carts;

  CartsResponse({required this.carts});

  factory CartsResponse.fromJson(Map<String, dynamic> json) => _$CartsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartsResponseToJson(this);
}

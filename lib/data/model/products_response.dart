import 'package:flutter_practice/core/app_imports.dart';
import 'package:json_annotation/json_annotation.dart';

import '../model/product_model.dart';

part 'products_response.g.dart';

@JsonSerializable()
class ProductsResponse {
  final List<Product> products;
  ProductsResponse({required this.products});

  factory ProductsResponse.fromJson(Map<String, dynamic> json) => _$ProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsResponseToJson(this);
}

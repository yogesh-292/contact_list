import 'package:dio/dio.dart';
import 'package:flutter_practice/data/model/products_response.dart';
import 'package:flutter_practice/data/model/recipe_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../data/model/quotes_response_model.dart';
import '../../data/model/carts_response.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {required String baseUrl}) = _RestClient;
  @GET('quotes')
  Future<QuotesResponse> getQuotes();

  @GET('products')
  Future<ProductsResponse> getProducts();

  @GET('carts')
  Future<CartsResponse> getCarts();

  @GET('recipes')
  Future<RecipesResponse> fetchRecipes();
}

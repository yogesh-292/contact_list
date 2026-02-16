import 'package:dio/dio.dart';
import 'package:flutter_practice/data/model/products_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../data/model/quotes_response_model.dart';

part 'quotes_api_service.g.dart';

@RestApi()
abstract class QuotesApiService {
  factory QuotesApiService(Dio dio, {required String baseUrl}) = _QuotesApiService;
  @GET('quotes')
  Future<QuotesResponse> getQuotes();

  @GET('products')
  Future<ProductsResponse> getProducts();
}

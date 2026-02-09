import 'package:flutter_practice/core/app_imports.dart';
import 'package:flutter_practice/core/network/network_module.dart';
import 'package:dio/dio.dart';
import './core/network/api_services.dart';
import './core/network/quotes_api_service.dart';

Future<void> initDependencies() async {
  Get
    ..lazyPut<Dio>(() => NetworkModule.prepareDio(), fenix: true)
    ..lazyPut<ApiService>(() => NetworkModule.getRestClient(), fenix: true)
    ..lazyPut<QuotesApiService>(() => NetworkModule.getQuotesClient(), fenix: true);
}

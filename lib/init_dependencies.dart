import 'package:flutter_practice/core/app_imports.dart';
import 'package:flutter_practice/core/network/network_module.dart';
import 'package:dio/dio.dart';
import 'package:talker/talker.dart';
import './core/network/api_services.dart';
import 'core/network/rest_client.dart';
import 'package:flutter_practice/core/logger/app_logger.dart';

Future<void> initDependencies() async {
  Get
    ..put<Talker>(talker)
    ..lazyPut<Dio>(() => NetworkModule.prepareDio(), fenix: true)
    ..lazyPut<ApiService>(() => NetworkModule.getRestClient(), fenix: true)
    ..lazyPut<RestClient>(() => NetworkModule.getQuotesClient(), fenix: true);
}

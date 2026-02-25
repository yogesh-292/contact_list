import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_practice/core/network/api_services.dart';
import 'package:flutter_practice/core/app_imports.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:flutter_practice/core/logger/app_logger.dart';
import 'rest_client.dart';

class NetworkModule {
  static Dio prepareDio() {
    final dio = Dio();

    dio.interceptors.add(ApiInterceptor());

    // Add Talker logger ONLY in debug mode
    if (kDebugMode) {
      dio.interceptors.add(
        TalkerDioLogger(
          talker: talker, // 👈 THIS is important
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printRequestData: true,
            printResponseData: true,
            printResponseHeaders: false,
          ),
        ),
      );
    }

    return dio;
  }

  static ApiService getRestClient() => ApiService(Get.find<Dio>(), baseUrl: BaseConfig.baseUrl);

  static RestClient getQuotesClient() => RestClient(Get.find<Dio>(), baseUrl: BaseConfig.quotesUrl);
}

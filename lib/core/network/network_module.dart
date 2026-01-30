import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_practice/core/network/api_services.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter_practice/core/app_imports.dart';

class NetworkModule {
  static Dio prepareDio() {
    final dio = Dio();

    dio.interceptors.add(ApiInterceptor());

    // Add logger ONLY in debug mode
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: false,
          maxWidth: 120,
        ),
      );
    }

    return dio;
  }

  ///pulls the already-registered Dio instance from GetX
  ///injects it into ApiService
  ///returns a fully configured API client

  static ApiService getRestClient() => ApiService(Get.find<Dio>(), baseUrl: BaseConfig.baseUrl);
}

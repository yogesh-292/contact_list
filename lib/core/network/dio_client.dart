import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter_practice/core/app_imports.dart';

class DioClient {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: BaseConfig.baseurl,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

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
}

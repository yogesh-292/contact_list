import 'package:dio/dio.dart';
import 'package:flutter_practice/core/app_imports.dart';

abstract class BaseController extends GetxController {
  final RxBool loading = false.obs;

  //Executes an API call safely

  Future<void> executeApi({
    required Future<dynamic> Function() request,

    ///onSuccess might exist
    ///if it exists, I can call it like:
    ///onSuccess(someData)
    Function(dynamic data)? onSuccess,
    Function(DioException error)? onError,
    bool showLoader = true,
  }) async {
    try {
      if (showLoader) loading.value = true;

      final response = await request();

      if (showLoader) loading.value = false;

      if (onSuccess != null) {
        onSuccess(response);
      }
    } on DioException catch (e) {
      if (showLoader) loading.value = false;

      _handleDioError(e);

      if (onError != null) {
        onError(e);
      }
    } catch (e) {
      if (showLoader) loading.value = false;
      debugPrint('Unexpected error: $e');
    }
  }

  //helper fucntion for error handling

  void _handleDioError(DioException error) {
    final statusCode = error.response?.statusCode;
    // Extracts error code or key from the response, if available.
    final message = error.response?.data?['message'];

    // Log all relevant error details for troubleshooting
    debugPrint(
      'API Error → $statusCode | ${error.requestOptions.uri} | $message',
    );
  }
}

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
    } on DioException catch (dioError) {
      if (showLoader) loading.value = false;

      if (dioError.response?.statusCode == HttpStatusCodes.forbidden) {
        debugPrint("403 error");
      } else if (dioError.response?.statusCode == HttpStatusCodes.unauthorized) {
        debugPrint("401 error");
      } else if (dioError.response?.statusCode == HttpStatusCodes.internalServerError) {
        debugPrint("500 error");
      }

      onErrorResponse(dioError);

      if (onError != null) {
        onError(dioError);
      }
    } catch (e) {
      if (showLoader) loading.value = false;
      debugPrint('Unexpected error: $e');
    }
  }

  //helper fucntion for error handling

  void onErrorResponse(DioException error) {
    final statusCode = error.response?.statusCode;

    String? message;

    final data = error.response?.data;

    if (data is Map<String, dynamic>) {
      message = data['message'];
    } else if (data is String) {
      message = data;
    }

    debugPrint(
      'API Error → $statusCode | ${error.requestOptions.uri} | $message',
    );
  }
}

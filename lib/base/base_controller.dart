import 'package:dio/dio.dart';
import 'package:flutter_practice/core/app_imports.dart';

abstract class BaseController extends GetxController {
  final RxBool loading = false.obs;

  //Executes an API call safely

  Future<void> executeApi({
    required Future<dynamic> Function() request,

    /// onSuccess callback (optional)
    /// - If provided, it will be called with the API response data
    /// - Example usage: onSuccess(userData) => processUserData(userData)
    /// - The callback receives the response from the API call
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
        Get.snackbar(
          "Client Error(403)",
          "this is a client side error",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (dioError.response?.statusCode == HttpStatusCodes.unauthorized) {
        debugPrint("401 error");
      } else if (dioError.response?.statusCode == HttpStatusCodes.internalServerError) {
        debugPrint("500 error");
      } else if (dioError.response?.statusCode == HttpStatusCodes.badGateway) {
        debugPrint('502 error');
      } else if (dioError.response?.statusCode == HttpStatusCodes.notFound) {
        debugPrint("404 error");
      } else if (dioError.response?.statusCode == HttpStatusCodes.tooManyRequests) {
        Get.snackbar("Dio Error", "api limit exceeded");
      } else if (true) {
        debugPrint('the response data ----> ${dioError.response?.data}');
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
    debugPrint('the dio error ----------> $error');
    final statusCode = error.response?.statusCode;

    String? message;

    final data = error.response?.data;

    if (data is Map<String, dynamic>) {
      message = data['message'];
    } else if (data is String) {
      message = data;
    }

    debugPrint('API Error → $statusCode | ${error.requestOptions.uri} | $message');
  }
}

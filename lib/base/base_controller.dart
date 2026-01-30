import 'package:dio/dio.dart';
import 'package:flutter_practice/core/app_imports.dart';

typedef ApiErrorHandler = Future<bool> Function(DioException error);

class BaseController extends GetxController {
  var isLoading = false.obs;

  Future<T?> callApi<T>(
    Future<T> request, {
    bool showLoader = true,
    ApiErrorHandler? apiErrorHandler,
    bool rethrowError = false,
    bool reportError = true,
  }) async {
    try {
      if (showLoader) isLoading.value = true;

      final response = await request;

      if (showLoader) isLoading.value = false;

      return response;
    } on DioException catch (dioError) {
      if (showLoader) isLoading.value = false;

      // 🌐 Handle specific HTTP status codes for better UX
      if (dioError.response?.statusCode == HttpStatusCode.badGateway.value) {
        // 502: Server is down
        debugPrint('⚠️ Server is down, please try again later.');
      } else if (dioError.response?.statusCode == HttpStatusCode.unauthorized.value) {
        // 401: Unauthorized
        debugPrint('🔒 Unauthorized access');
      } else if (dioError.response?.statusCode == HttpStatusCode.badRequest.value) {
        // 400: Bad request
        debugPrint('🚫 Forbidden access');
      } else if (dioError.response?.statusCode == HttpStatusCode.notFound.value) {
        // 404: Not found
        debugPrint('❓ Resource not found');
      } else if (dioError.response?.statusCode == HttpStatusCode.internalServerError.value) {
        // 500: Internal server error
        debugPrint('💥 Internal server error');
      } else if (dioError.response?.statusCode == HttpStatusCode.found.value) {
        return dioError.response?.data;
      } else {
        // Other status codes
        debugPrint('API call for endpoint ${request.toString()} with status code: ${dioError.response?.statusCode}');
      }

      // 🛠️ Use custom error handler if provided, else fallback to default
      if (apiErrorHandler != null) {
        final result = await apiErrorHandler(dioError);
        if (!result) {
          await onResponseError(dioError);
        }
      } else {
        await onResponseError(dioError);
      }
    } catch (error) {
      if (showLoader) {}
      if (rethrowError) rethrow;
      if (reportError) {
        // 📝 Log unexpected errors for debugging
        final logErrorMessage = 'callApi method error :: Error -> ${error.runtimeType} => $error';
        debugPrint(logErrorMessage);
      }
    }
    // Return null if an error occurred
    return null;
  }

  Future<void> onResponseError(DioException error) async {
    try {
      final url = error.requestOptions.uri.toString();
      final headers = error.requestOptions.headers;
      final queryParams = error.requestOptions.queryParameters;
      final data = error.requestOptions.data;
      final errorStatusCode = error.response?.statusCode;
      final errorMessage = error.response?.data?['message'];
      // Extracts error code or key from the response, if available.
      final errorKey = error.response?.data?['errorCode'] as String? ?? error.response?.data?['error'] as String? ?? '';
      // 🐞 Log all relevant error details for troubleshooting
      debugPrint(
        'onResponseError: $errorKey || $errorStatusCode || $url || $queryParams || $headers || $data || $errorMessage',
      );
    } catch (e) {
      // Catch and log any exceptions thrown during error handling itself.
      debugPrint('Exception returned from onResponseError: ${e.toString()}');
      return;
    }
  }
}

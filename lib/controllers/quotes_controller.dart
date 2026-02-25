import 'package:flutter_practice/core/app_imports.dart';
import 'package:flutter_practice/data/model/quotes_model.dart';

/// ------------------------------------------------------------
/// QuotesController
/// ------------------------------------------------------------
/// This controller is responsible for:
/// - Fetching quotes from the API
/// - Managing quotes state using GetX reactive variables
/// - Handling loading, success, and error states
/// - Providing user feedback via Snackbar
///
/// It extends [BaseController], which provides the `executeApi`
/// helper method for structured API handling.
/// ------------------------------------------------------------
class QuotesController extends BaseController {
  /// Reactive nullable string used to store error messages.
  /// If an error occurs during API call, this will hold the message.
  final RxnString error = RxnString();

  /// Reactive list of quotes.
  /// `.obs` makes it observable so UI updates automatically
  /// whenever new data is assigned.
  final RxList<Quote> quotes = <Quote>[].obs;

  /// ------------------------------------------------------------
  /// Lifecycle Method
  /// ------------------------------------------------------------
  /// Called automatically when the controller is initialized.
  /// We trigger fetching quotes here so data loads immediately.
  /// ------------------------------------------------------------
  @override
  void onInit() {
    super.onInit();
    fetchQuotes();
  }

  /// ------------------------------------------------------------
  /// fetchQuotes()
  /// ------------------------------------------------------------
  /// Makes an API call to retrieve quotes.
  ///
  /// Responsibilities:
  /// - Calls API using executeApi helper
  /// - Shows loader while fetching data
  /// - Validates response type
  /// - Updates reactive quotes list on success
  /// - Handles unexpected response formats
  /// - Stores error message on failure
  /// ------------------------------------------------------------
  Future<void> fetchQuotes() {
    return executeApi(
      /// API request function
      request: () => apiService.getQuotes(),

      /// Enables loading indicator (handled inside BaseController)
      showLoader: true,

      /// Called when API request succeeds
      onSuccess: (data) {
        /// If API returns null data
        if (data == null) {
          error.value = 'No data received';
          return;
        }

        /// Debug: print runtime type of response
        debugPrint('the runtime type of the quotes data is -----> ${data.runtimeType}');

        /// Ensure response is of expected type before processing
        if (data is QuotesResponse) {
          /// Update reactive quotes list
          quotes.assignAll(data.quotes);

          /// Show success message to user
          Get.snackbar(
            "Success",
            "Quotes fetched successfully",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green.shade600,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
        } else {
          /// If API response format is unexpected
          Get.snackbar("Server Error", "Unexpected response format", snackPosition: SnackPosition.BOTTOM);
        }
      },

      /// Called when API request fails
      onError: (err) {
        /// Debug log for developers
        debugPrint("error while fetching quotes ---> $err");

        /// Store error message in reactive variable
        error.value = err.toString();
      },
    );
  }
}

import 'package:flutter_practice/core/app_imports.dart';

/// ------------------------------------------------------------
/// UserController
/// ------------------------------------------------------------
/// This controller is responsible for:
/// - Fetching user (contact) data from the API
/// - Managing user state using GetX reactive variables
/// - Handling loading, success, and error states
/// - Providing feedback to the user via Snackbar
///
/// It extends [BaseController], which provides the `executeApi`
/// helper method to standardize API execution and error handling.
/// ------------------------------------------------------------
class UserController extends BaseController {
  /// Reactive nullable string used to store error messages.
  /// If API fails or returns invalid data, this will contain the error.
  final RxnString error = RxnString();

  /// Reactive list that stores fetched users.
  /// `.obs` makes it observable so UI automatically rebuilds
  /// when the user list changes.
  final RxList<User> users = <User>[].obs;

  /// ------------------------------------------------------------
  /// Lifecycle Method - onInit()
  /// ------------------------------------------------------------
  /// Called automatically when the controller is initialized.
  /// We trigger fetching users here so data loads immediately.
  /// ------------------------------------------------------------
  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  /// ------------------------------------------------------------
  /// fetchUsers()
  /// ------------------------------------------------------------
  /// Responsible for:
  /// - Making API request to retrieve users
  /// - Showing loader while fetching (showLoader: true)
  /// - Validating response type
  /// - Updating reactive user list on success
  /// - Handling unexpected response formats
  /// - Logging errors if request fails
  /// ------------------------------------------------------------
  void fetchUsers() {
    executeApi(
      /// API request function
      request: () => userApiService.getUsers(),

      /// Enables loading indicator (handled inside BaseController)
      showLoader: true,

      /// Called when API request succeeds
      onSuccess: (data) {
        /// Handle null response
        if (data == null) {
          error.value = 'No data received';
          return;
        }

        /// Debug: print runtime type of response
        debugPrint('the runtime type of data -----> ${data.runtimeType}');

        /// Ensure response is a List<User> before assigning
        if (data is List<User>) {
          /// Update reactive users list
          users.assignAll(data);

          /// Show success message to user
          Get.snackbar(
            "Success",
            "Contacts fetched successfully",
            snackPosition: SnackPosition.BOTTOM,
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
      onError: (error) {
        /// Debug log for developers
        debugPrint("Failed to fetch users -----> $error");
      },
    );
  }
}

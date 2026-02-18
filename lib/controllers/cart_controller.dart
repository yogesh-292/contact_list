import 'package:flutter_practice/core/app_imports.dart';
import 'package:flutter_practice/core/network/quotes_api_service.dart';

/// ------------------------------------------------------------
/// CartController
/// ------------------------------------------------------------
/// This controller is responsible for:
/// - Fetching cart data from the API
/// - Managing cart state using GetX reactive variables
/// - Providing user feedback via Snackbar
/// - Holding the full CartsResponse if needed
///
/// It extends [BaseController], which provides the `executeApi`
/// helper method for structured API execution handling.
/// ------------------------------------------------------------
class CartController extends BaseController {
  /// Injected API service using GetX dependency injection.
  /// Used to perform network calls related to cart data.
  final QuotesApiService apiService = Get.find<QuotesApiService>();

  /// Reactive list that stores individual cart items.
  /// `.obs` makes it observable so UI automatically updates
  /// when cart data changes.
  final RxList<Cart> carts = <Cart>[].obs;

  /// Reactive nullable object that holds the complete
  /// CartsResponse from the API.
  /// Useful if additional metadata exists in the response.
  final Rxn<CartsResponse> cartsResponse = Rxn<CartsResponse>();

  /// ------------------------------------------------------------
  /// Lifecycle Method - onInit()
  /// ------------------------------------------------------------
  /// Called automatically when the controller is created.
  /// We trigger fetching carts here so data loads immediately.
  /// ------------------------------------------------------------
  @override
  void onInit() {
    super.onInit();
    fetchCarts();
  }

  /// ------------------------------------------------------------
  /// Lifecycle Method - onClose()
  /// ------------------------------------------------------------
  /// Called automatically when the controller is disposed.
  /// Useful for cleaning resources or debugging lifecycle.
  /// ------------------------------------------------------------
  @override
  void onClose() {
    debugPrint("Cart Controller Deleted");
  }

  /// ------------------------------------------------------------
  /// fetchCarts()
  /// ------------------------------------------------------------
  /// Responsible for:
  /// - Making API request to fetch cart data
  /// - Validating response type
  /// - Updating reactive state variables
  /// - Showing success or error Snackbar
  /// ------------------------------------------------------------
  void fetchCarts() {
    executeApi(
      /// API request function
      request: () => apiService.getCarts(),

      /// Called when API request succeeds
      onSuccess: (data) {
        /// Store raw response reference
        final response = data;

        /// Ensure response type is correct before processing
        if (data is CartsResponse) {
          /// Update reactive cart list
          carts.assignAll(response.carts);

          /// Show success message to user
          Get.snackbar(
            "Success",
            "Carts fetched successfully",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green.shade600,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
        } else {
          /// If API returns unexpected format
          Get.snackbar("Server Error", "Unexpected response format", snackPosition: SnackPosition.BOTTOM);
        }

        /// Store full response in reactive variable
        cartsResponse.value = response;

        /// Assign carts again (ensures UI consistency if needed)
        carts.assignAll(response.carts);
      },
    );
  }
}

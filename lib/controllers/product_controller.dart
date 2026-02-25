import 'package:flutter_practice/core/app_imports.dart';

/// ------------------------------------------------------------
/// ProductController
/// ------------------------------------------------------------
/// This controller is responsible for:
/// - Fetching product data from the API
/// - Managing product state using GetX reactive variables
/// - Handling API success and error states
/// - Showing user feedback via Snackbar
///
/// It extends [BaseController], which provides the `executeApi`
/// method for handling API calls in a structured way.
/// ------------------------------------------------------------
class ProductController extends BaseController {
  /// Reactive list that holds all fetched products.
  /// `.obs` makes it observable so UI updates automatically.
  final RxList<Product> products = <Product>[].obs;

  /// Reactive nullable string used to store error messages.
  /// If API fails, this will contain the error description.
  final RxnString error = RxnString();

  /// ------------------------------------------------------------
  /// Lifecycle Method
  /// ------------------------------------------------------------
  /// Called automatically when the controller is initialized.
  /// We trigger product fetching here so data loads immediately
  /// when the controller is created.
  /// ------------------------------------------------------------
  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  /// ------------------------------------------------------------
  /// fetchProducts()
  /// ------------------------------------------------------------
  /// Responsible for:
  /// - Making API request to fetch products
  /// - Updating product list on success
  /// - Handling unexpected response formats
  /// - Handling errors
  /// - Showing user feedback via Snackbar
  /// ------------------------------------------------------------
  void fetchProducts() {
    executeApi(
      /// API request function
      request: () => apiService.getProducts(),

      /// Called when API request succeeds
      onSuccess: (data) {
        /// Debug: prints the runtime type of API response
        debugPrint('the runtime type of response ------> ${data.runtimeType}');
        // Expected type: ProductsResponse

        final response = data;

        /// Ensure response is of correct type before processing
        if (data is ProductsResponse) {
          /// Update reactive product list
          products.assignAll(response.products);

          /// Clear previous error (if any)
          error.value = null;

          debugPrint('Products loaded: ${products.length}');

          /// Show success message to user
          Get.snackbar(
            "Success",
            "Products fetched successfully",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green.shade600,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
        } else {
          /// If API returns unexpected format
          Get.snackbar("Server Error", "Unexpected response format", snackPosition: SnackPosition.BOTTOM);
        }
      },

      /// Called when API request fails
      onError: (e) {
        /// Store error message in reactive variable
        error.value = 'Failed to load products';

        /// Debug log for developer
        debugPrint('error caught ---> $e');
      },
    );
  }
}

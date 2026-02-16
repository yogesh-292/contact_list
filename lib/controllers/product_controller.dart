import 'package:flutter_practice/core/app_imports.dart';

import '../core/network/quotes_api_service.dart';

class ProductController extends BaseController {
  final QuotesApiService _quotesApiService = Get.find<QuotesApiService>();

  final RxList<Product> products = <Product>[].obs;
  final RxnString error = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() {
    executeApi(
      request: () => _quotesApiService.getProducts(),
      onSuccess: (data) {
        debugPrint('the runtime type of response ------> ${data.runtimeType}'); //type --->ProductsResponse
        final response = data;

        if (data is ProductsResponse) {
          products.assignAll(response.products);
          error.value = null;

          debugPrint('Products loaded: ${products.length}');

          Get.snackbar(
            "Success",
            "Products fetched successfully",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green.shade600,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
        } else {
          Get.snackbar("server error", "Unexpected response format", snackPosition: SnackPosition.BOTTOM);
        }
      },
      onError: (e) {
        error.value = 'Failed to load products';
        debugPrint('error caught ---> $e');
      },
    );
  }
}

import 'package:flutter_practice/core/app_imports.dart';
import 'package:flutter_practice/data/model/quotes_model.dart';
import '../core/network/quotes_api_service.dart';

class QuotesController extends BaseController {
  final QuotesApiService _quotesApiService = Get.find<QuotesApiService>();

  final RxnString error = RxnString();
  final RxList<Quote> quotes = <Quote>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuotes();
  }

  Future<void> fetchQuotes() {
    return executeApi(
      request: () => _quotesApiService.getQuotes(),
      showLoader: true,
      onSuccess: (data) {
        if (data == null) {
          error.value = 'No data recieved';
          return;
        }

        debugPrint('the runtime type of the quotes data is -----> ${data.runtimeType}');

        if (data is QuotesResponse) {
          quotes.assignAll(data.quotes);

          Get.snackbar(
            "Success",
            "Quotes fetched successfully",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green.shade600,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
        } else {
          Get.snackbar("server error", "Unexpected response format", snackPosition: SnackPosition.BOTTOM);
        }
      },
      onError: (err) {
        debugPrint("error while fetching quotes ---> $err");
        error.value = err.toString();
      },
    );
  }
}

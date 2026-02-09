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

  void fetchQuotes() {
    executeApi(
      request: () => _quotesApiService.getQuotes(),
      showLoader: true,
      onSuccess: (data) {
        if (data == null) {
          error.value = 'No data received';
          return;
        }

        debugPrint('the runtimeType of the quotes data is ------> ${data.runtimeType}');

        if (data is QuotesResponse) {
          quotes.assignAll(data.quotes);
        } else {
          debugPrint('Unxpected response type: ${data.runtimeType}');
        }
      },
      onError: (err) {
        debugPrint("Error while fetching quotes ---> $err");
        error.value = err.toString();
      },
    );
  }
}

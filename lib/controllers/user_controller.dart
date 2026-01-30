import '../core/network/api_services.dart';
import 'package:flutter_practice/core/app_imports.dart';

class UserController extends BaseController {
  final ApiService _apiService = Get.find<ApiService>();

  final RxnString error = RxnString();
  final RxList<User> users = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final result = await callApi(
      _apiService.getUsers(),
      showLoader: true,
    );
    debugPrint('runtime type: ${result.runtimeType}');

    if (result is List<User>) {
      users.assignAll(result);
    } else {
      Get.snackbar("Server Error", "this is an internal server Error");
    }
  }
}

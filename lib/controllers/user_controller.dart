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

    if (result != null) {
      debugPrint('runtime type: ${result.runtimeType}');
      users.assignAll(result);
    }
  }
}

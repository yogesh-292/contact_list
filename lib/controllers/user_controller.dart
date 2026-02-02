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

  void fetchUsers() {
    executeApi(
        request: () => _apiService.getUsers(),
        showLoader: true,
        onSuccess: (data) {
          if (data == null) {
            error.value = 'No data recieved';
            return;
          }
          debugPrint('the runtime type of data -----> ${data.runtimeType}');

          if (data is List<User>) {
            users.assignAll(data);
          } else {
            Get.snackbar("server error", "this is an internal server Error");
          }
        },
        onError: (error) {
          Get.snackbar('Error', 'Failed to fetch users');
        });
  }
}

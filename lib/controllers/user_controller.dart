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

            Get.snackbar("Success", "Contacts fetched successfully",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green.shade600,
                colorText: Colors.white,
                duration: const Duration(seconds: 2));
          } else {
            Get.snackbar("server error", "Unexpected response format", snackPosition: SnackPosition.BOTTOM);
          }
        },
        onError: (error) {
          debugPrint("Failed to fetch users -----> $error");
        });
  }
}

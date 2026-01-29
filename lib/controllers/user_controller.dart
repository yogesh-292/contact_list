import 'package:get/get.dart';
import '../data/services/api_services.dart';
import '../data/model/user_model.dart';

class UserController extends GetxController {
  final ApiService _apiService = ApiService.create();

  final RxBool isLoading = true.obs;
  final RxnString error = RxnString();
  final RxList<User> users = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      error.value = null;

      final result = await _apiService.getUsers();
      users.assignAll(result);
    } catch (e) {
      print('error----> $e');
    } finally {
      isLoading.value = false;
    }
  }
}

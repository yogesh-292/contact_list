import 'package:get/get.dart';
import '../core/network/dio_client.dart';
import '../core/network/api_services.dart';
import '../data/model/user_model.dart';

class UserController extends GetxController {
  late final ApiService _apiService;

  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();
  final RxList<User> users = <User>[].obs;

  @override
  void onInit() {
    super.onInit();

    final dio = DioClient.create();
    _apiService = ApiService(dio);

    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      error.value = null;

      final result = await _apiService.getUsers();
      users.assignAll(result);
    } catch (e) {
      print('error---> $e');
    } finally {
      isLoading.value = false;
    }
  }
}

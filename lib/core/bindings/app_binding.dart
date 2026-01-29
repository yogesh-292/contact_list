import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../network/dio_client.dart';
import '../network/api_services.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(() => DioClient.create(), fenix: true);

    Get.lazyPut<ApiService>(() => ApiService(Get.find<Dio>()), fenix: true);
  }
}

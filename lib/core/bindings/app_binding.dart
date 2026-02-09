import 'package:flutter_practice/controllers/quotes_controller.dart';
import 'package:flutter_practice/controllers/user_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => QuotesController(), fenix: true);
  }
}

import 'package:connect_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:connect_app/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(HomeController(), permanent: true);
  }
}

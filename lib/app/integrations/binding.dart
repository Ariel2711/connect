import 'package:connect_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:connect_app/app/modules/home/controllers/home_controller.dart';
import 'package:connect_app/app/modules/input/controllers/input_controller.dart';
import 'package:connect_app/app/modules/profil/controllers/profil_controller.dart';
import 'package:connect_app/app/modules/search/controllers/search_controller.dart';
import 'package:get/get.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(HomeController(), permanent: true);
    Get.put(InputBeritaController());
    Get.put(SearchController());
    Get.put(ProfilController());
  }
}

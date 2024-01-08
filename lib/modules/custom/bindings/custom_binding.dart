import 'package:biomteric_auth/modules/custom/controllers/custom_controller.dart';
import 'package:get/get.dart';

class CustomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomController>(() => CustomController());
  }
}

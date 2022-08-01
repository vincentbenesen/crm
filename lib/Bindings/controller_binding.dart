import 'package:get/get.dart';

import '../Controllers/record_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecordController>(() => RecordController());
  }
}

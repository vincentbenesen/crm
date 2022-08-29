import 'package:crm/Controllers/log_controller.dart';
import 'package:crm/Controllers/recordUpdate_controller.dart';
import 'package:crm/Controllers/stepper_controller.dart';
import 'package:crm/Controllers/table_controller.dart';
import 'package:get/get.dart';

import '../Controllers/record_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecordController>(() => RecordController());
    Get.lazyPut<StepperController>(() => StepperController());
    Get.lazyPut<TableController>(() => TableController());
    Get.lazyPut<LogController>(() => LogController());
    Get.lazyPut<RecordUpdateController>(() => RecordUpdateController());
  }
}

import 'package:get/get.dart';

import 'package:crm/Controllers/log_controller.dart';
import 'package:crm/Controllers/mail_controller.dart';
import 'package:crm/Controllers/recordUpdate_controller.dart';
import 'package:crm/Controllers/stepper_controller.dart';
import 'package:crm/Controllers/table_controller.dart';
import 'package:crm/services/auth_service.dart';
import '../Controllers/record_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecordController>(() => RecordController());
    Get.lazyPut<StepperController>(() => StepperController());
    Get.lazyPut<TableController>(() => TableController());
    Get.lazyPut<LogController>(() => LogController());
    Get.lazyPut<RecordUpdateController>(() => RecordUpdateController());
    Get.lazyPut<MailController>(() => MailController());
    Get.lazyPut<AuthService>(() => AuthService());
  }
}

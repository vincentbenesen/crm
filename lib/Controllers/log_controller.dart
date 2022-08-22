import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogController extends GetxController {
  // To access the records from the database.
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;

  // This variable is used to check which section is selected
  final currentSection = 'call'.obs;

  @override
  void onInit() {
    super.onInit();
    collectionReference = firestore.collection('logs');
  }
}

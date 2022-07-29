import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/record.dart';

class RecordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController,
      lastNameController,
      address1Controller,
      address2Controller,
      cityController,
      provinceController,
      postalCodeController;

  final recordList = <Record>[].obs;
  final record = Record.empty().obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxInt highestId = 0.obs;

  late CollectionReference collectionReference;

  @override
  void onInit() {
    super.onInit();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    address1Controller = TextEditingController();
    address2Controller = TextEditingController();
    cityController = TextEditingController();
    provinceController = TextEditingController();
    postalCodeController = TextEditingController();

    collectionReference = firestore.collection('records');
  }

  Future<void> fetchRecords() async {
    QuerySnapshot records = await collectionReference.orderBy('userId').get();

    records.docs.forEach((record) {
      recordList.add(Record(
          record['userId'], record['fieldId'], record['type'], record['data']));
    });
  }

  // Adds the records in Firestore
  void addRecords(List<Record> records) async {
    int highestId = await getHighestUserId();
    highestId++;
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      records.forEach((record) {
        collectionReference.add(record.toMap(highestId));
      });
      records.clear();
      formKey.currentState?.reset();
    }
  }

  // Returns the highest userId from Firestore
  Future<int> getHighestUserId() async {
    try {
      Future<QuerySnapshot<Object?>> record = collectionReference
          .orderBy('userId', descending: true)
          .limit(1)
          .get();
      return await record.then((QuerySnapshot querySnapshot) {
        return (querySnapshot.docs.first['userId']);
      });
    } catch (e) {
      return Future<int>.value(0);
    }
  }
}

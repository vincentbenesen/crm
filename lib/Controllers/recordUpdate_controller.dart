import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crm/Models/record_update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RecordUpdateController extends GetxController {
  // To access the records from the database.
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;

  List<RecordUpdate> recordUpdates = <RecordUpdate>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    collectionReference = firestore.collection('historyOfAction');
  }

  // This method insert all the updates in Firebase
  // This is use to keep track of all changes in user's information
  void insertAllUdpates() {
    recordUpdates.forEach((recordUpdate) {
      collectionReference.add(recordUpdate.toMap());
    });

    recordUpdates.clear();
  }

  // This method is used to create a new instance of RecordUpdate class
  void createRecordUpdate(
      int userId, String type, String oldData, String newData) {
    DateTime currentDate = DateTime.now();

    recordUpdates.add(RecordUpdate(userId, type, oldData, newData,
        DateFormat('yyyy-MM-dd kk:mm a').format(currentDate)));
  }
}

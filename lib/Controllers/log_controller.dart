import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:crm/Models/record.dart';
import 'package:crm/constant.dart';

class LogController extends GetxController {
  // To access the records from the database.
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;

  final emailFormKey = GlobalKey<FormState>();

  // This variable is used to check which section is selected
  final currentSection = 'call'.obs;
  final isPressCompossedEmail = false.obs;

  @override
  void onInit() {
    super.onInit();
    collectionReference = firestore.collection('logs');
  }

  // Show the form depending on what type of logs (log a call, log a meeting, send an email)
  Widget showLogContent(List<Record> records) {
    switch (currentSection.value) {
      case 'call':
        return Text('');
      case 'meeting':
        return Text('');
      case 'email':
        return Text('');

      default:
        return Text('hi');
    }
  }
}

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
  Widget showLogContent(List<Record> records, double screenWidth) {
    switch (currentSection.value) {
      case 'call':
        if (screenWidth >= 1600) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: SizedBox(
                  height: 35,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Recap your call...',
                      labelStyle: kEditLeadLabelStyle2,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: kColorDarkBlue),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: kColorDarkBlue),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 35,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kColorDarkBlue),
                    child: Text('Add', style: kButtonText3)),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              const SizedBox(height: 12),
              SizedBox(
                height: 35,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Recap your call...',
                    labelStyle: kEditLeadLabelStyle2,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: kColorDarkBlue),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: kColorDarkBlue),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 35,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kColorDarkBlue),
                    child: Text('Add', style: kButtonText3)),
              ),
            ],
          );
        }

      case 'meeting':
        return Text('');
      case 'email':
        return Text('');

      default:
        return Text('hi');
    }
  }
}

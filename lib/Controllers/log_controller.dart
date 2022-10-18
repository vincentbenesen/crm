import 'package:crm/Models/log.dart';
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
  final callTextController = TextEditingController();
  final meetingTextController = TextEditingController();
  final emailTextController = TextEditingController();

  final logList = <Log>[].obs;

  // These variables are used to track the number of interaction with the client
  RxInt callCount = 0.obs;
  RxInt meetingCount = 0.obs;
  RxInt receivedEmailCount = 0.obs;
  RxInt sentEmailCount = 0.obs;
  RxInt userId = 0.obs;

  // This variable is used to check which section is selected
  final currentSection = 'call'.obs;
  final isPressCompossedEmail = false.obs;

  @override
  void onInit() async {
    super.onInit();
    collectionReference = firestore.collection('logs');

    callCount.value = await callLogCount(userId.value);
    meetingCount.value = await meetingLogCount(userId.value);
    // receivedEmailCount.value = await emailReceiveCount(userId.value);
  }

  // Insert the log in the Firebase
  void addLog(
      String typeOfData, String data, int userId, List<Record> records) {
    DateTime currentDate = DateTime.now();
    Log logToInsert = Log(userId, currentDate, typeOfData, data);

    logToInsert.docId = collectionReference.doc().id;

    collectionReference.doc(logToInsert.docId).set(logToInsert.toMap());

    Get.offAllNamed('/LeadDetails', arguments: {'records': records});
  }

  // Get all the logs depending of the userId
  Future<List<Log>> getAllLogs(int userId) async {
    QuerySnapshot logs = await collectionReference
        .orderBy('date', descending: true)
        .where('userId', isEqualTo: userId)
        .get();

    logs.docs.forEach((log) {
      Timestamp timeStamp = log['date'];
      logList.add(Log(
          log['userId'],
          DateTime.fromMillisecondsSinceEpoch(timeStamp.millisecondsSinceEpoch),
          log['typeOfData'],
          log['data'],
          log['docId']));
    });

    return logList;
  }

  Future<int> callLogCount(int userId) async {
    QuerySnapshot callCount = await collectionReference
        .where('typeOfData', isEqualTo: 'call')
        .where('userId', isEqualTo: userId)
        .get();

    return callCount.docs.length;

    // return logs.where((log) => log.userId == userId).length;
  }

  Future<int> emailReceiveCount(int userId) async {
    QuerySnapshot emailReceivedCount = await collectionReference
        .where('typeOfData', isEqualTo: 'receivedEmail')
        .where('userId', isEqualTo: userId)
        .get();

    return emailReceivedCount.docs.length;
  }

  Future<int> meetingLogCount(int userId) async {
    QuerySnapshot meetingCount = await collectionReference
        .where('typeOfData', isEqualTo: 'meeting')
        .where('userId', isEqualTo: userId)
        .get();

    return meetingCount.docs.length;
  }

  // Show the form depending on what type of logs (log a call, log a meeting, send an email)
  Widget showLogContent(List<Record> records, double screenWidth, int userId) {
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
                    controller: callTextController,
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
                    onPressed: () {
                      Get.find<LogController>().addLog(
                          'call', callTextController.text, userId, records);
                    },
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
                  controller: callTextController,
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
                    onPressed: () {
                      Get.find<LogController>().addLog(
                          'call', callTextController.text, userId, records);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kColorDarkBlue),
                    child: Text('Add', style: kButtonText3)),
              ),
            ],
          );
        }

      case 'meeting':
        print(callCount.value);
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
                    controller: meetingTextController,
                    decoration: InputDecoration(
                      labelText: 'Recap your meeting...',
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
                    onPressed: () {
                      Get.find<LogController>().addLog('meeting',
                          meetingTextController.text, userId, records);
                    },
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
                  controller: meetingTextController,
                  decoration: InputDecoration(
                    labelText: 'Recap your meeting...',
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
                    onPressed: () {
                      Get.find<LogController>().addLog('meeting',
                          meetingTextController.text, userId, records);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kColorDarkBlue),
                    child: Text('Add', style: kButtonText3)),
              ),
            ],
          );
        }
      case 'email':
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
                    controller: emailTextController,
                    decoration: InputDecoration(
                      labelText: 'Recap your email received from the client...',
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
                    onPressed: () {
                      Get.find<LogController>().addLog('receivedEmail',
                          emailTextController.text, userId, records);
                    },
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
                  controller: emailTextController,
                  decoration: InputDecoration(
                    labelText: 'Recap your email received from the client...',
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
                    onPressed: () {
                      Get.find<LogController>().addLog('receivedEmail',
                          emailTextController.text, userId, records);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kColorDarkBlue),
                    child: Text('Add', style: kButtonText3)),
              ),
            ],
          );
        }

      default:
        return Text('');
    }
  }

  Icon getIcon(String typeOfData) {
    switch (typeOfData) {
      case 'sentEmail':
        return Icon(
          Icons.email,
          size: 30,
          color: Colors.yellow[400],
        );
      case 'receivedEmail':
        return Icon(
          Icons.contact_mail,
          size: 30,
          color: Colors.green[400],
        );
      case 'call':
        return Icon(
          Icons.contact_phone,
          size: 30,
          color: Colors.blue[400],
        );
      case 'meeting':
        return Icon(
          Icons.event,
          size: 30,
          color: Colors.red[400],
        );
      default:
        return Icon(Icons.email);
    }
  }

  String getSubtitle(String typeOfData) {
    switch (typeOfData) {
      case 'receivedEmail':
        return 'received an email';
      case 'call':
        return 'logged a call';
      case 'meeting':
        return 'had an event';
      default:
        return '';
    }
  }
}

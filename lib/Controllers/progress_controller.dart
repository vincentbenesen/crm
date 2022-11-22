import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crm/Controllers/analytics_controller.dart';
import 'package:crm/Models/progressData.dart';
import 'package:crm/Models/record.dart';
import 'package:crm/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference progressReference;
  late CollectionReference recordReference;

  RxInt progressLevel = 0.obs;
  var progressRecord = Record(0, 0, '', '', '').obs;
  var currentColor = kColorDarkBlue.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    progressReference = firestore.collection('progress');
    recordReference = firestore.collection('records');
  }

// Compares the difference from the current date.
  int compareDate(DateTime from) {
    DateTime today = DateTime.now();
    return (from.difference(today).inDays);
  }

  // Insert all the progress records per user. Each user will have different progress record
  void insertProgressRecords(List<ProgressData> progressList) {
    progressList.forEach((progressData) {
      progressData.documentId = progressReference.doc().id;
      progressReference.doc(progressData.documentId).set(progressData.toMap());
    });
  }

  // Update the estimate date
  void updateProgressRecord(ProgressData? progressData, DateTime? dateTime) {
    progressReference
        .doc(progressData!.documentId)
        .update({'estimateDate': dateTime});
  }

  // Generate a list of progressdata based on the list of progress title
  List<ProgressData> generateListOfProgressData(
      List<String> listOfProgressTitle, int userId) {
    List<ProgressData> progressDataList = [];
    listOfProgressTitle.forEach((title) {
      progressDataList.add(ProgressData(userId, title, 'N/A', 'N/A'));
    });

    return progressDataList;
  }

  // Get the list of progress data from
  List<ProgressData> getProgressDataList(QuerySnapshot<Object?> snapshot) {
    List<ProgressData> progressDataList = [];

    snapshot.docs.forEach((progressData) {
      Timestamp? estimateDate;
      Timestamp? finishDate;
      try {
        estimateDate = progressData[kEstimateDate];
        finishDate = progressData[kFinishDate];
        progressDataList.add(ProgressData(
            progressData[kUserId],
            progressData[kTitle],
            DateTime.fromMillisecondsSinceEpoch(
                    estimateDate!.millisecondsSinceEpoch)
                .toString(),
            DateTime.fromMillisecondsSinceEpoch(
                    finishDate!.millisecondsSinceEpoch)
                .toString(),
            progressData['documentId']));
      } catch (e) {
        progressDataList.add(ProgressData(
            progressData[kUserId],
            progressData[kTitle],
            progressData[kEstimateDate] == 'N/A'
                ? 'N/A'
                : DateTime.fromMillisecondsSinceEpoch(
                        estimateDate!.millisecondsSinceEpoch)
                    .toString(),
            progressData[kFinishDate] == 'N/A'
                ? 'N/A'
                : DateTime.fromMillisecondsSinceEpoch(
                        finishDate!.millisecondsSinceEpoch)
                    .toString(),
            progressData['documentId']));
      }
    });
    return progressDataList;
  }

  // Get the list of progress data by using the id of the user
  List<ProgressData>? getListProgressDataById(
      List<ProgressData> progressDataList, int userId) {
    Map<int, List<ProgressData>> pDataMap =
        convertListToMapPData(progressDataList);

    return pDataMap[userId];
  }

  // Get the progress data based on the given title
  ProgressData? getProgressData(
      String title, List<ProgressData> progressListData) {
    ProgressData? currentData;
    for (ProgressData progressData in progressListData) {
      if (progressData.title == title) {
        currentData = progressData;
      }
    }
    return currentData;
  }

  // Convert the list of progress data to a map
  Map<int, List<ProgressData>> convertListToMapPData(
      List<ProgressData> listPData) {
    Map<int, List<ProgressData>> pDataMap = <int, List<ProgressData>>{};

    for (ProgressData pData in listPData) {
      if (pDataMap.containsKey(pData.userId)) {
        pDataMap[pData.userId]!.add(pData);
      } else {
        pDataMap.addEntries([
          MapEntry(pData.userId, [pData])
        ]);
      }
    }

    return pDataMap;
  }

  // Update the current progress level number on the firebase
  void updateProgress(Record record) {
    recordReference.doc(record.documentId).update({
      'data': record.data,
    });
  }

  Color getColor(ProgressData? progressData) {
    if (progressData?.estimateDate == 'N/A') {
      return kColorDarkBlue;
    } else if (compareDate(
            DateTime.parse((progressData?.estimateDate).toString())) <=
        0) {
      return Color.fromARGB(255, 131, 50, 44);
    } else if (compareDate(
                DateTime.parse((progressData?.estimateDate).toString())) <=
            10 &&
        compareDate(DateTime.parse((progressData?.estimateDate).toString())) >
            0) {
      return Colors.orange;
    } else {
      return kColorDarkBlue;
    }
  }
}

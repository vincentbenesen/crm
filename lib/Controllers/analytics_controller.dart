import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crm/Controllers/table_controller.dart';
import 'package:crm/Models/chartdata.dart';
import 'package:crm/Models/log.dart';
import 'package:crm/Models/record.dart';
import 'package:crm/constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:async/async.dart';

class AnalyticsController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference recordsCollection;
  late CollectionReference logsCollection;
  var tableController = Get.find<TableController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    recordsCollection = firestore.collection('records');
    logsCollection = firestore.collection('logs');
  }

  // Compares the difference from the current date.
  int compareDate(DateTime from) {
    DateTime today = DateTime.now();
    return (today.difference(from).inDays);
  }

  // Get both collections (records and logs) from Firebase and it returns a querysnapshot
  Stream<List<QuerySnapshot>> getData() {
    Stream<QuerySnapshot<Object?>> recordsSnapshot =
        recordsCollection.snapshots();
    Stream<QuerySnapshot<Object?>> logsSnapshot = logsCollection.snapshots();
    return StreamZip([recordsSnapshot, logsSnapshot]);
  }

  // Get the records from query snapshot
  List<Record> getRecords(QuerySnapshot<Object?> snapshot) {
    List<Record> recordsList = [];

    snapshot.docs.forEach((record) {
      recordsList.add(Record(
          record['userId'], record['fieldId'], record['type'], record['data']));
    });

    return recordsList;
  }

  // Get the logs form query snapshot
  List<Log> getLogs(QuerySnapshot<Object?> snapshot) {
    List<Log> logsList = [];

    snapshot.docs.forEach((log) {
      Timestamp timeStamp = log['date'];
      logsList.add(Log(
          log['userId'],
          DateTime.fromMillisecondsSinceEpoch(timeStamp.millisecondsSinceEpoch),
          log['typeOfData'],
          log['data'],
          log['docId']));
    });
    return logsList;
  }

  // Convers the list of logs to map of logs
  Map<int, List<Log>> convertListOfLogsToMap(List<Log> logs) {
    Map<int, List<Log>> logsMap = <int, List<Log>>{};

    for (Log log in logs) {
      if (logsMap.containsKey(log.userId)) {
        logsMap[log.userId]!.add(log);
      } else {
        logsMap.addEntries([
          MapEntry(log.userId, [log])
        ]);
      }
    }

    return logsMap;
  }

  List<ChartData> getChartData(
      Map<int, List<Record>> recordsMap, Map<int, List<Log>> logsMap) {
    List<ChartData> chartDataList = [];

    // Sorts the map based on the last name of the lead
    var sortedMap = Map.fromEntries(recordsMap.entries.toList()
      ..sort((e1, e2) => tableController
          .getRecordByFieldType(kLastName, e2.value)
          .data
          .compareTo(
              tableController.getRecordByFieldType(kLastName, e1.value).data)));

    sortedMap.forEach((key, value) {
      try {
        chartDataList.add(ChartData(
            '${tableController.getRecordByFieldType(kFirstName, value).data} ${Get.find<TableController>().getRecordByFieldType(kLastName, value).data}',
            compareDate(logsMap[key]!.first.date)));
      } catch (e) {
        chartDataList.add(ChartData(
            '${tableController.getRecordByFieldType(kFirstName, value).data} ${Get.find<TableController>().getRecordByFieldType(kLastName, value).data}',
            0));
      }
    });

    return chartDataList;
  }
}

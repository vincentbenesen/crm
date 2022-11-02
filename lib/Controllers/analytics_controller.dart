import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crm/Controllers/table_controller.dart';
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    recordsCollection = firestore.collection('records');
    logsCollection = firestore.collection('logs');
  }

  double compareDate(DateTime from) {
    DateTime today = DateTime.now();
    return (today.difference(from).inDays).toDouble();
  }

  Stream<List<QuerySnapshot>> getData() {
    Stream<QuerySnapshot<Object?>> recordsSnapshot =
        recordsCollection.snapshots();
    Stream<QuerySnapshot<Object?>> logsSnapshot = logsCollection.snapshots();
    return StreamZip([recordsSnapshot, logsSnapshot]);
  }

  List<Record> getRecords(QuerySnapshot<Object?> snapshot) {
    List<Record> recordsList = [];

    snapshot.docs.forEach((record) {
      recordsList.add(Record(
          record['userId'], record['fieldId'], record['type'], record['data']));
    });
    return recordsList;
  }

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

  List<BarChartGroupData> getBarChartGroupData(
      Map<int, List<Log>> logs, Map<int, List<Record>> recordsMap) {
    List<BarChartGroupData> barChartGroupData = [];

    // logs.forEach((key, value) {
    //   barChartGroupData.add(BarChartGroupData(x: key, barRods: [
    //     BarChartRodData(toY: compareDate(value[0].date), color: kColorDarkBlue)
    //   ]));
    // });

    recordsMap.forEach((key, value) {
      try {
        barChartGroupData.add(BarChartGroupData(x: key, barRods: [
          BarChartRodData(
              toY: compareDate(logs[key]!.first.date), color: kColorDarkBlue)
        ]));
      } catch (e) {
        barChartGroupData.add(BarChartGroupData(
            x: key, barRods: [BarChartRodData(toY: 0, color: kColorDarkBlue)]));
      }
    });

    return barChartGroupData;
  }

  // Get the name of the customer and put is as a bottom label of te
  SideTitles getBottomTitle(Map<int, List<Record>> recordsMap) {
    return SideTitles(
        showTitles: true,
        getTitlesWidget: ((value, meta) {
          String name = '';

          name =
              '${Get.find<TableController>().getRecordByFieldType('firstName', recordsMap[value.toInt()]!).data} ${Get.find<TableController>().getRecordByFieldType('lastName', recordsMap[value.toInt()]!).data}';

          return Text(name);
        }));
  }
}

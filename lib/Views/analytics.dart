import 'package:crm/Controllers/analytics_controller.dart';
import 'package:crm/Controllers/table_controller.dart';
import 'package:crm/Widgets/chartContainer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:crm/Widgets/custom_AppBar.dart';
import 'package:crm/Widgets/navbar.dart';
import 'package:crm/constant.dart';
import 'package:get/get.dart';
import 'package:http/retry.dart';
import 'package:fl_chart/fl_chart.dart';

class Analytics extends StatelessWidget {
  Analytics({super.key});

  var analyticController = Get.find<AnalyticsController>();
  var tableController = Get.find<TableController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      drawer: Navbar(),
      backgroundColor: kColorDarkBlue,
      body: StreamBuilder(
        stream: analyticController.getData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<QuerySnapshot>> snapshot) {
          if (snapshot.hasData) {
            List<QuerySnapshot> querySnapshotData = snapshot.data!.toList();
            // analyticController.getRecords(querySnapshotData[kRecordIndex]);
            print(analyticController.convertListOfLogsToMap(
                analyticController.getLogs(querySnapshotData[kLogIndex])));
            return SingleChildScrollView(
              child: Column(
                children: [
                  ChartContainer(
                    title: "Days Without Interaction",
                    color: kColorPearlWhite,
                    chart: BarChart(
                      BarChartData(
                        barGroups: analyticController.getBarChartGroupData(
                            analyticController.convertListOfLogsToMap(
                              analyticController
                                  .getLogs(querySnapshotData[kLogIndex]),
                            ),
                            tableController.convertListToMap(analyticController
                                .getRecords(querySnapshotData[kRecordIndex]))),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: analyticController.getBottomTitle(
                              tableController.convertListToMap(
                                  analyticController.getRecords(
                                      querySnapshotData[kRecordIndex])),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Text('No data avaible right now');
          }
        },
      ),
    );
  }
}

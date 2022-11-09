import 'package:crm/Controllers/analytics_controller.dart';
import 'package:crm/Controllers/table_controller.dart';
import 'package:crm/Models/chartdata.dart';
import 'package:crm/Widgets/chartContainer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:crm/Widgets/custom_AppBar.dart';
import 'package:crm/Widgets/navbar.dart';
import 'package:crm/constant.dart';
import 'package:get/get.dart';
import 'package:http/retry.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

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
            // print(analyticController.convertListOfLogsToMap(
            //     analyticController.getLogs(querySnapshotData[kLogIndex])));
            return SingleChildScrollView(
              child: Column(
                children: [
                  ChartContainer(
                    title: "Days Without Interaction",
                    color: kColorPearlWhite,
                    chart: SfCartesianChart(
                      primaryXAxis:
                          CategoryAxis(visibleMinimum: 0, visibleMaximum: 5),
                      zoomPanBehavior: ZoomPanBehavior(
                        enablePanning: true,
                      ),
                      primaryYAxis:
                          NumericAxis(minimum: 0, maximum: 40, interval: 4),
                      series: <ChartSeries<ChartData, String>>[
                        BarSeries<ChartData, String>(
                            dataSource: analyticController.getChartData(
                                tableController.convertListToMap(
                                    analyticController.getRecords(
                                        querySnapshotData[kRecordIndex])),
                                analyticController.convertListOfLogsToMap(
                                    analyticController.getLogs(
                                        querySnapshotData[kLogIndex]))),
                            xValueMapper: (ChartData ch, _) => ch.title,
                            yValueMapper: (ChartData ch, _) => ch.value,
                            color: kColorDarkBlue),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data avaible right now'));
          }
        },
      ),
    );
  }
}

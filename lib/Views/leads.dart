import 'package:crm/services/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:crm/constant.dart';
import 'package:crm/Controllers/record_controller.dart';
import 'package:crm/Controllers/table_controller.dart';
import 'package:crm/Widgets/navbar.dart';
import '../Models/record.dart';

class Leads extends StatelessWidget {
  const Leads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Get.find<RecordController>().fetchRecords(),
      builder: ((context, snapshot) {
        try {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Navbar(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                const Icon(Icons.group),
                                const SizedBox(width: 5),
                                Text("Leads", style: kTextTitle)
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                RaisedButton(
                                  onPressed: () {
                                    print(snapshot.data);
                                    Get.offAllNamed("/Panel");
                                  },
                                  color: Colors.white,
                                  child:
                                      Text("Add new lead", style: kButtonText1),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                  snapshot.data == null
                      ? Container(
                          child: const Center(
                            child: CircularProgressIndicator(
                              value: 10,
                            ),
                          ),
                        )
                      : Obx(
                          () => Container(
                            width: MediaQuery.of(context).size.width,
                            child: DataTable(
                              columnSpacing: 10,
                              dataRowHeight: 80,
                              columns: Get.find<TableController>().getColumns(
                                  Get.find<TableController>().leadsColumns,
                                  snapshot.data as List<Record>,
                                  context),
                              rows: Get.find<TableController>()
                                  .getRows(snapshot.data as List<Record>),
                              sortColumnIndex: 0,
                              sortAscending:
                                  Get.find<TableController>().isAscending.value,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        } catch (e) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Navbar(),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}

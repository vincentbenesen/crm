import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:crm/constant.dart';
import 'package:crm/Controllers/record_controller.dart';
import 'package:crm/Controllers/table_controller.dart';
import 'package:crm/Widgets/navbar.dart';
import 'package:crm/Widgets/custom_AppBar.dart';
import '../Models/record.dart';

class Leads extends StatelessWidget {
  Leads({Key? key}) : super(key: key);

  // These variables are for controllers
  var recordController = Get.find<RecordController>();
  var tableController = Get.find<TableController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Navbar(),
        appBar: CustomAppbar(),
        body: StreamBuilder(
          stream: Stream.fromFuture(recordController.fetchRecords()),
          builder: ((context, snapshot) {
            try {
              return SingleChildScrollView(
                child: Column(
                  children: [
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
                            // Searchbar
                            Container(
                              width: 500,
                              child: TextField(
                                controller: tableController.searchController,
                                decoration: InputDecoration(
                                    hoverColor: kColorDarkBlue,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 20),
                                    suffixIcon: InkWell(
                                        onTap: () {
                                          // Go to searchLeads page
                                          // It also passed some data from lead to searchLeads page
                                          // These data are the searched lead/user
                                          Get.offAllNamed(kToSearchedLeads,
                                              arguments: {
                                                'searchedResults':
                                                    tableController.result(
                                                        snapshot.data
                                                            as List<Record>,
                                                        tableController.matchesName(
                                                            snapshot.data
                                                                as List<Record>,
                                                            tableController
                                                                .searchController
                                                                .text)),
                                                'allLeads': snapshot.data
                                                    as List<Record>
                                              });
                                        },
                                        child: Icon(Icons.search)),
                                    hintText: 'Search...'),
                              ),
                            ),

                            // Row for import and addlead buttons
                            Row(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.offAllNamed(kToPanel);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                        ),
                                        child: Text("Add new lead",
                                            style: kButtonText1),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      // This button is for importing the data from the excel to firebase
                                      ElevatedButton(
                                        onPressed: () {
                                          recordController.importFile();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                        ),
                                        child: Text("Import a file",
                                            style: kButtonText1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                                columns: tableController.getColumns(
                                    tableController.leadsColumns,
                                    snapshot.data as List<Record>,
                                    context),
                                rows: tableController
                                    .getRows(snapshot.data as List<Record>),
                                sortColumnIndex: 0,
                                sortAscending:
                                    tableController.isAscending.value,
                              ),
                            ),
                          ),
                  ],
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
        ));
  }
}

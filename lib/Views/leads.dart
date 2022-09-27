import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:crm/constant.dart';
import 'package:crm/Controllers/record_controller.dart';
import 'package:crm/Controllers/table_controller.dart';
import 'package:crm/Widgets/navbar.dart';
import 'package:crm/services/auth_service.dart';
import 'package:crm/Widgets/custom_AppBar.dart';
import '../Models/record.dart';

class Leads extends StatelessWidget {
  const Leads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Navbar(),
        appBar: CustomAppbar(),
        body: FutureBuilder(
          future: Get.find<RecordController>().fetchRecords(),
          builder: ((context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return CircularProgressIndicator();
            // } else if (snapshot.connectionState == ConnectionState.done) {
            //   if (snapshot.hasError) {
            //     return const Text('Error');
            //   } else if (snapshot.hasData) {
            //     List<Record> list = snapshot.data as List<Record>;
            //     // print(list.length);
            //     // print('HI${Get.find<RecordController>().highestUserId.value}');

            //     // print('${Get.find<TableController>().matches(list, 'L')}');
            //     return Column(
            //       children: [
            //         Container(
            //           width: MediaQuery.of(context).size.width,
            //           height: 50,
            //           padding: const EdgeInsets.symmetric(horizontal: 20),
            //           child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Container(
            //                   child: Row(
            //                     children: [
            //                       const Icon(Icons.group),
            //                       const SizedBox(width: 5),
            //                       Text("Leads", style: kTextTitle)
            //                     ],
            //                   ),
            //                 ),
            //                 // SearchField
            //                 Expanded(
            //                   child: TextField(
            //                     controller: Get.find<TableController>()
            //                         .searchController,
            //                     decoration: InputDecoration(
            //                         prefixIcon: Icon(Icons.search),
            //                         hintText: 'Search...'),
            //                   ),
            //                 ),
            //                 // SearchButton
            //                 Container(
            //                   child: Row(
            //                     children: [
            //                       ElevatedButton(
            //                         onPressed: () {
            //                           Get.find<TableController>().name.value =
            //                               Get.find<TableController>()
            //                                   .searchController
            //                                   .text;

            //                           print(Get.find<TableController>().matches(
            //                               list,
            //                               Get.find<TableController>()
            //                                   .name
            //                                   .value));

            //                           Get.find<TableController>()
            //                               .numOfMatches
            //                               .value = Get.find<
            //                                   TableController>()
            //                               .result(
            //                                   list,
            //                                   Get.find<TableController>()
            //                                       .matches(
            //                                           list,
            //                                           Get.find<
            //                                                   TableController>()
            //                                               .name
            //                                               .value))
            //                               .length;
            //                         },
            //                         style: ElevatedButton.styleFrom(
            //                           backgroundColor: Colors.white,
            //                         ),
            //                         child: Text("Search", style: kButtonText1),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 Container(
            //                   child: Row(
            //                     children: [
            //                       ElevatedButton(
            //                         onPressed: () {
            //                           print(snapshot.data);
            //                           Get.offAllNamed("/Panel");
            //                         },
            //                         style: ElevatedButton.styleFrom(
            //                           backgroundColor: Colors.white,
            //                         ),
            //                         child: Text("Add new lead",
            //                             style: kButtonText1),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ]),
            //         ),
            //         ListView.builder(
            //           scrollDirection: Axis.vertical,
            //           shrinkWrap: true,
            //           itemCount:
            //               Get.find<RecordController>().highestUserId.value,
            //           itemBuilder: (context, index) {
            //             return Obx(
            //                 (() => Get.find<TableController>().name.value == ""
            //                     ? Table(
            //                         children: [
            //                           TableRow(children: [
            //                             Text(
            //                                 '${Get.find<TableController>().getRecordByFieldType('firstName', Get.find<TableController>().getRecordsByIndex(list, index)).data} ${Get.find<TableController>().getRecordByFieldType('lastName', Get.find<TableController>().getRecordsByIndex(list, index)).data}'),
            //                             Text('${Get.find<TableController>().getRecordByFieldType(
            //                                   'address1',
            //                                   Get.find<TableController>()
            //                                       .getRecordsByIndex(
            //                                           list, index),
            //                                 ).data} ${Get.find<TableController>().getRecordByFieldType('city', Get.find<TableController>().getRecordsByIndex(list, index)).data}, ${Get.find<TableController>().getRecordByFieldType('province', Get.find<TableController>().getRecordsByIndex(list, index)).data}, ${Get.find<TableController>().getRecordByFieldType('postal', Get.find<TableController>().getRecordsByIndex(list, index)).data}')
            //                           ])
            //                         ],
            //                       )
            //                     : Table(
            //                         children: [
            //                           TableRow(children: [
            //                             // Text(
            //                             //     '${Get.find<TableController>().getRecordByFieldType('firstName', Get.find<TableController>().getRecordsByIndex(Get.find<TableController>().result(list, Get.find<TableController>().matches(list, Get.find<TableController>().name.value)), 3)).data}'),
            //                             // Text('Hi')
            //                           ])
            //                         ],
            //                       )));
            //           },
            //         ),
            //       ],
            //     );
            //   } else {
            //     return const Text('Empty data');
            //   }
            // } else {
            //   return Text('State: ${snapshot.connectionState}');
            // }

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
                            Container(
                              child: Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      print(snapshot.data);
                                      Get.offAllNamed("/Panel");
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
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.find<RecordController>().importFile();
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
                                sortAscending: Get.find<TableController>()
                                    .isAscending
                                    .value,
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

          //(This is for the listview.builder)
          // }),
        ));
  }
}

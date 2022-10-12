import 'package:awesome_dialog/awesome_dialog.dart';
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

class SearchedLeads extends StatelessWidget {
  const SearchedLeads({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
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
                          InkWell(
                              onTap: () {
                                Get.offAllNamed('/Leads');
                              },
                              child: Text("Leads", style: kTextTitle))
                        ],
                      ),
                    ),

                    Container(
                      width: 500,
                      child: TextField(
                        controller:
                            Get.find<TableController>().searchController,
                        decoration: InputDecoration(
                            hoverColor: kColorDarkBlue,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            suffixIcon: InkWell(
                                onTap: () {
                                  // When the searched icon is clicked, it searches names
                                  Get.offAllNamed('/SearchedLeads', arguments: {
                                    'searchedResults':
                                        Get.find<TableController>().result(
                                            Get.arguments['allLeads'],
                                            Get.find<TableController>()
                                                .matchesName(
                                                    Get.arguments['allLeads'],
                                                    Get.find<TableController>()
                                                        .searchController
                                                        .text)),
                                    'allLeads': Get.arguments['allLeads']
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
                                  Get.arguments['searchedResults'];
                                  Get.offAllNamed("/Panel");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                child:
                                    Text("Add new lead", style: kButtonText1),
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
                                child:
                                    Text("Import a file", style: kButtonText1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
            // Checks if theres a result from the search
            (Get.arguments['searchedResults'] as List<Record>).isEmpty
                ? Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                        child: Text(
                      'No Results',
                      style: kEditLeadTextH1,
                    )),
                  )
                : Obx(
                    () => Container(
                      width: MediaQuery.of(context).size.width,
                      child: DataTable(
                        columnSpacing: 10,
                        dataRowHeight: 80,
                        columns: Get.find<TableController>().getColumns(
                            Get.find<TableController>().leadsColumns,
                            Get.arguments['searchedResults'],
                            context),
                        rows: Get.find<TableController>()
                            .getRows(Get.arguments['searchedResults']),
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
  }
}
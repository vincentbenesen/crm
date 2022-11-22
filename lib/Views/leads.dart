import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crm/Controllers/analytics_controller.dart';
import 'package:crm/Controllers/progress_controller.dart';
import 'package:crm/Models/progressData.dart';
import 'package:crm/Widgets/customCheckBox.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:crm/constant.dart';
import 'package:crm/Controllers/record_controller.dart';
import 'package:crm/Controllers/table_controller.dart';
import 'package:crm/Controllers/filter_controller.dart';
import 'package:crm/Widgets/navbar.dart';
import 'package:crm/Widgets/custom_AppBar.dart';
import '../Models/record.dart';

class Leads extends StatelessWidget {
  Leads({Key? key}) : super(key: key);

  // These variables are for controllers
  var recordController = Get.find<RecordController>();
  var tableController = Get.find<TableController>();
  var filterController = Get.find<FilterController>();
  var progressController = Get.find<ProgressController>();
  var analyticController = Get.find<AnalyticsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Navbar(),
        appBar: CustomAppbar(),
        body: StreamBuilder(
          stream: recordController.getRecordsAndLogs()
          // Stream.fromFuture(recordController.fetchRecords())
          ,
          builder: ((BuildContext context,
              AsyncSnapshot<List<QuerySnapshot>> snapshot) {
            if (snapshot.hasData) {
              List<QuerySnapshot> querySnapshotData = snapshot.data!.toList();
              List<Record> recordsList = analyticController
                  .getRecords(querySnapshotData[kRecordIndex]);

              List<ProgressData> progressDataList =
                  progressController.getProgressDataList(querySnapshotData[1]);

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
                                                        recordsList,
                                                        tableController.matchesName(
                                                            recordsList,
                                                            tableController
                                                                .searchController
                                                                .text)),
                                                'allLeads': recordsList,
                                                'progressDataList':
                                                    progressDataList
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
                                IconButton(
                                  icon: const Icon(Icons.filter_list),
                                  color: kColorDarkBlue,
                                  onPressed: () {
                                    filterController.isFilterButtonClicked();
                                  },
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
                            () => filterController.isFilterPressed.value
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: DataTable(
                                            columnSpacing: 10,
                                            dataRowHeight: 80,
                                            columns: tableController.getColumns(
                                                tableController.leadsColumns,
                                                recordsList,
                                                context),
                                            rows: tableController.getRows(
                                                recordsList, progressDataList),
                                            sortColumnIndex:
                                                tableController.index.value,
                                            sortAscending: tableController
                                                .isAscending.value,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          color: kColorDarkerBlue,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Filters',
                                                  style: kLeadFilterTitle,
                                                ),
                                                const SizedBox(height: 10),
                                                Column(
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Get.offAllNamed(
                                                            kToFilteredLeads,
                                                            arguments: {
                                                              'filteredResults':
                                                                  filterController
                                                                      .filterRecords(
                                                                          tableController
                                                                              .convertListToMap(recordsList)),
                                                              'allLeads':
                                                                  recordsList,
                                                              'progressDataList':
                                                                  progressDataList
                                                            });

                                                        print(filterController
                                                            .filterRecords(
                                                                tableController
                                                                    .convertListToMap(
                                                                        recordsList)));
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.white,
                                                      ),
                                                      child: Text("Submit",
                                                          style: kButtonText1),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                // This filter is for Provinces and States
                                                Container(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: filterController
                                                                  .isCityOptionOpen
                                                                  .value
                                                              ? const BorderRadius
                                                                      .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5))
                                                              : BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                filterController
                                                                    .isCityButtonClicked();
                                                              },
                                                              child: Icon(filterController
                                                                      .isCityOptionOpen
                                                                      .value
                                                                  ? Icons
                                                                      .keyboard_arrow_down
                                                                  : Icons
                                                                      .keyboard_arrow_right),
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            Text(
                                                              "Prov/State",
                                                              style:
                                                                  KLeadFilterChoices,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Obx(() => filterController
                                                              .isCityOptionOpen
                                                              .value
                                                          ? Container(
                                                              color:
                                                                  Colors.white,
                                                              height: 500,
                                                              child: ListView
                                                                  .builder(
                                                                      scrollDirection:
                                                                          Axis
                                                                              .vertical,
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemCount:
                                                                          kStateList
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              count) {
                                                                        return CustomCheckBox(
                                                                          label:
                                                                              kStateList[count],
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 10),
                                                                          optionsToAdd: filterController
                                                                              .citiesToSearch
                                                                              .value,
                                                                          isRatings: !filterController
                                                                              .isForRatings
                                                                              .value,
                                                                        );
                                                                      }),
                                                            )
                                                          : Container())
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                // This filter is for the type of units
                                                Container(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: filterController
                                                                  .isTypeOfUnitOpen
                                                                  .value
                                                              ? const BorderRadius
                                                                      .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5))
                                                              : BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                filterController
                                                                    .isTypeOfUnitButtonClicked();
                                                              },
                                                              child: Icon(filterController
                                                                      .isTypeOfUnitOpen
                                                                      .value
                                                                  ? Icons
                                                                      .keyboard_arrow_down
                                                                  : Icons
                                                                      .keyboard_arrow_right),
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            Text(
                                                              "Units",
                                                              style:
                                                                  KLeadFilterChoices,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Obx(() => filterController
                                                              .isTypeOfUnitOpen
                                                              .value
                                                          ? Container(
                                                              color:
                                                                  Colors.white,
                                                              height: 500,
                                                              child: ListView
                                                                  .builder(
                                                                      scrollDirection:
                                                                          Axis
                                                                              .vertical,
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemCount:
                                                                          kTypeOfCondoUnitList
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              count) {
                                                                        return CustomCheckBox(
                                                                            label:
                                                                                kTypeOfCondoUnitList[count],
                                                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                            optionsToAdd: filterController.unitsToSearch,
                                                                            isRatings: !filterController.isForRatings.value);
                                                                      }),
                                                            )
                                                          : Container())
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                // This filter is for the number of ratings
                                                Container(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: filterController
                                                                  .isRatingOptionOPen
                                                                  .value
                                                              ? const BorderRadius
                                                                      .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5))
                                                              : BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                filterController
                                                                    .isRatingButtonClicked();
                                                              },
                                                              child: Icon(filterController
                                                                      .isRatingOptionOPen
                                                                      .value
                                                                  ? Icons
                                                                      .keyboard_arrow_down
                                                                  : Icons
                                                                      .keyboard_arrow_right),
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            Text(
                                                              "Ratings",
                                                              style:
                                                                  KLeadFilterChoices,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Obx(() => filterController
                                                              .isRatingOptionOPen
                                                              .value
                                                          ? Container(
                                                              color:
                                                                  Colors.white,
                                                              height: 200,
                                                              child: ListView
                                                                  .builder(
                                                                      scrollDirection:
                                                                          Axis
                                                                              .vertical,
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemCount:
                                                                          kRatingsList
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              count) {
                                                                        return CustomCheckBox(
                                                                          label:
                                                                              kTypeOfCondoUnitList[count],
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 10),
                                                                          optionsToAdd:
                                                                              filterController.unitsToSearch,
                                                                          isRatings: filterController
                                                                              .isForRatings
                                                                              .value,
                                                                          rating:
                                                                              kRatingsList[count],
                                                                          ratingsToAdd:
                                                                              filterController.ratingsToSearch,
                                                                        );
                                                                      }),
                                                            )
                                                          : Container())
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: DataTable(
                                      columnSpacing: 10,
                                      dataRowHeight: 80,
                                      columns: tableController.getColumns(
                                          tableController.leadsColumns,
                                          recordsList,
                                          context),
                                      rows: tableController.getRows(
                                          recordsList, progressDataList),
                                      sortColumnIndex:
                                          tableController.index.value,
                                      sortAscending:
                                          tableController.isAscending.value,
                                    ),
                                  ),
                          ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  value: 10,
                ),
              );
            }
          }),
        ));
  }
}

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
import '../Controllers/filter_controller.dart';
import '../Models/record.dart';
import '../Widgets/customCheckBox.dart';

class FilteredLeads extends StatelessWidget {
  FilteredLeads({super.key});

  // These variables are for controllers
  var recordController = Get.find<RecordController>();
  var tableController = Get.find<TableController>();
  var filterController = Get.find<FilterController>();

  // This variable is used to access the argument passed from Leads page.
  var argumentLeadList = Get.arguments['allLeads'];
  var argumentSearchedResultList = Get.arguments['filteredResults'];
  var argumentsProgressList = Get.arguments['progressDataList'];

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
                                Get.offAllNamed(kToLead);
                              },
                              child: Text("Leads", style: kTextTitle))
                        ],
                      ),
                    ),

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
                                  // When the searched icon is clicked, it searches names
                                  Get.offAllNamed(kToSearchedLeads, arguments: {
                                    'searchedResults': tableController.result(
                                        argumentLeadList,
                                        tableController.matchesName(
                                            argumentLeadList,
                                            tableController
                                                .searchController.text)),
                                    'allLeads': argumentLeadList
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
                                  argumentSearchedResultList;
                                  Get.offAllNamed(kToPanel);
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
                                  recordController.importFile();
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
            // Checks if theres a result from the search
            (argumentSearchedResultList as List<Record>).isEmpty
                ? Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                        child: Text(
                      'No Results',
                      style: kEditLeadTextH1,
                    )),
                  )
                : Obx(
                    () => filterController.isFilterPressed.value
                        ? Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  child: DataTable(
                                    columnSpacing: 10,
                                    dataRowHeight: 80,
                                    columns: tableController.getColumns(
                                        tableController.leadsColumns,
                                        argumentSearchedResultList,
                                        context),
                                    rows: tableController.getRows(
                                        argumentSearchedResultList,
                                        argumentsProgressList),
                                    sortColumnIndex:
                                        tableController.index.value,
                                    sortAscending:
                                        tableController.isAscending.value,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
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
                                        Column(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                              ),
                                              child: Text("Submit",
                                                  style: kButtonText1),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        // Container for all the options
                                        Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: filterController
                                                          .isCityOptionOpen
                                                          .value
                                                      ? const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                          topRight:
                                                              Radius.circular(
                                                                  5))
                                                      : BorderRadius.circular(
                                                          5),
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
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      "Prov/State",
                                                      style: KLeadFilterChoices,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Obx(() => filterController
                                                      .isCityOptionOpen.value
                                                  ? Container(
                                                      color: Colors.white,
                                                      height: 500,
                                                      child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          shrinkWrap: true,
                                                          itemCount:
                                                              kStateList.length,
                                                          itemBuilder:
                                                              (context, count) {
                                                            return CustomCheckBox(
                                                              label: kStateList[
                                                                  count],
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
                                                              optionsToAdd:
                                                                  filterController
                                                                      .citiesToSearch
                                                                      .value,
                                                              isRatings:
                                                                  !filterController
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
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: filterController
                                                          .isTypeOfUnitOpen
                                                          .value
                                                      ? const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                          topRight:
                                                              Radius.circular(
                                                                  5))
                                                      : BorderRadius.circular(
                                                          5),
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
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      "Units",
                                                      style: KLeadFilterChoices,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Obx(
                                                  () =>
                                                      filterController
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
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: filterController
                                                          .isRatingOptionOPen
                                                          .value
                                                      ? const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                          topRight:
                                                              Radius.circular(
                                                                  5))
                                                      : BorderRadius.circular(
                                                          5),
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
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      "Ratings",
                                                      style: KLeadFilterChoices,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Obx(() => filterController
                                                      .isRatingOptionOPen.value
                                                  ? Container(
                                                      color: Colors.white,
                                                      height: 200,
                                                      child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          shrinkWrap: true,
                                                          itemCount:
                                                              kRatingsList
                                                                  .length,
                                                          itemBuilder:
                                                              (context, count) {
                                                            return CustomCheckBox(
                                                              label:
                                                                  kTypeOfCondoUnitList[
                                                                      count],
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
                                                              optionsToAdd:
                                                                  filterController
                                                                      .unitsToSearch,
                                                              isRatings:
                                                                  filterController
                                                                      .isForRatings
                                                                      .value,
                                                              rating:
                                                                  kRatingsList[
                                                                      count],
                                                              ratingsToAdd:
                                                                  filterController
                                                                      .ratingsToSearch,
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
                                  argumentSearchedResultList,
                                  context),
                              rows: tableController.getRows(
                                  argumentSearchedResultList,
                                  argumentsProgressList),
                              sortColumnIndex: tableController.index.value,
                              sortAscending: tableController.isAscending.value,
                            ),
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}

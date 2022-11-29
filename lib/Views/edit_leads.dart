import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:crm/Widgets/editableCompletionBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:crm/constant.dart';
import 'package:crm/Controllers/record_controller.dart';
import 'package:crm/Controllers/table_controller.dart';
import 'package:crm/Controllers/recordUpdate_controller.dart';
import 'package:crm/Widgets/navbar.dart';
import 'package:crm/Widgets/custom_AppBar.dart';

class EditLeads extends StatelessWidget {
  EditLeads({Key? key}) : super(key: key);

  // These variables are for controller
  var recordController = Get.find<RecordController>();
  var tableController = Get.find<TableController>();
  var recordUpdateController = Get.find<RecordUpdateController>();

  // This variable is used to access the argument passed from LeadDetails page.
  var argumentRecordList = Get.arguments['records'];
  var argumentProgressList = Get.arguments['progressDataList'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      drawer: Navbar(),
      backgroundColor: kColorDarkBlue,
      body: Form(
        key: recordController.updateFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              EditableCompletionBar(
                recordsList: argumentRecordList,
                progressDataList: argumentProgressList,
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: 800,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    child: Column(
                      children: [
                        //For the ratings
                        Container(
                          child: Column(
                            children: [
                              Text("Ratings", style: kTextTitle),
                              const SizedBox(height: 5),
                              RatingBar.builder(
                                initialRating: double.parse(tableController
                                    .getRecordByFieldType(
                                        "ratings", argumentRecordList)
                                    .data),
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                glow: false,
                                itemCount: 5,
                                itemSize: 30,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: kColorStar,
                                ),
                                onRatingUpdate: (rating) {
                                  recordController.rating.value = rating;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Details
                        Container(
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: kColorPearlWhite,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(children: [
                                  InkWell(
                                    onTap: () {
                                      if (tableController
                                              .showContactInfo.value ==
                                          false) {
                                        tableController.setToTrue(
                                            tableController.showContactInfo);
                                      } else {
                                        tableController.setToFalse(
                                            tableController.showContactInfo);
                                      }
                                    },
                                    child:
                                        const Icon(Icons.keyboard_arrow_down),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Details",
                                    style: kEditLeadTextH1,
                                  ),
                                ]),
                              ),
                              Obx(() => tableController.showContactInfo.value ==
                                      true
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 70,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              initialValue: tableController
                                                  .getRecordByFieldType(
                                                      kFirstName,
                                                      argumentRecordList)
                                                  .data,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                labelText: "First Name",
                                                labelStyle: kEditLeadTextH2,
                                              ),
                                              validator: (String? value) {
                                                return recordController
                                                    .isStringEmpty(value);
                                              },
                                              onSaved: (value) {
                                                // Check if the data has changed before updating the database
                                                if (tableController
                                                        .getRecordByFieldType(
                                                            kFirstName,
                                                            argumentRecordList)
                                                        .data !=
                                                    value.toString()) {
                                                  // Adds an RecordUpdate in the the list of updates
                                                  // RecordUpdate class allows us to track the changes we did in the user's information
                                                  recordUpdateController.createRecordUpdate(
                                                      tableController
                                                          .getRecordByFieldType(
                                                              kFirstName,
                                                              argumentRecordList)
                                                          .userId,
                                                      tableController
                                                          .getRecordByFieldType(
                                                              kFirstName,
                                                              argumentRecordList)
                                                          .type,
                                                      tableController
                                                          .getRecordByFieldType(
                                                              kFirstName,
                                                              argumentRecordList)
                                                          .data,
                                                      value.toString());

                                                  // Change the data of the record based on the given field type
                                                  tableController
                                                      .getRecordByFieldType(
                                                          kFirstName,
                                                          argumentRecordList)
                                                      .data = value.toString();

                                                  // Add the updated record to the list of updated records
                                                  recordController
                                                      .recordsToUpdate
                                                      .add(tableController
                                                          .getRecordByFieldType(
                                                              kFirstName,
                                                              argumentRecordList));
                                                }
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 30),
                                          Expanded(
                                            child: TextFormField(
                                              initialValue: tableController
                                                  .getRecordByFieldType(
                                                      kLastName,
                                                      argumentRecordList)
                                                  .data,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                labelText: "Last Name",
                                                labelStyle: kEditLeadTextH2,
                                              ),
                                              validator: (String? value) {
                                                return recordController
                                                    .isStringEmpty(value);
                                              },
                                              onSaved: (value) {
                                                // Check if the data has changed before updating the database
                                                if (tableController
                                                        .getRecordByFieldType(
                                                            kLastName,
                                                            argumentRecordList)
                                                        .data !=
                                                    value.toString()) {
                                                  // Adds an RecordUpdate in the the list of updates
                                                  // RecordUpdate class allows us to track the changes we did in the user's information
                                                  recordUpdateController.createRecordUpdate(
                                                      tableController
                                                          .getRecordByFieldType(
                                                              kLastName,
                                                              argumentRecordList)
                                                          .userId,
                                                      tableController
                                                          .getRecordByFieldType(
                                                              kLastName,
                                                              argumentRecordList)
                                                          .type,
                                                      tableController
                                                          .getRecordByFieldType(
                                                              kLastName,
                                                              argumentRecordList)
                                                          .data,
                                                      value.toString());

                                                  // Change the data of the record based on the given field type
                                                  tableController
                                                      .getRecordByFieldType(
                                                          kLastName,
                                                          argumentRecordList)
                                                      .data = value.toString();

                                                  // Add the updated record to the list of updated records
                                                  recordController
                                                      .recordsToUpdate
                                                      .add(tableController
                                                          .getRecordByFieldType(
                                                              kLastName,
                                                              argumentRecordList));
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container())
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Contact Information
                        Container(
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: kColorPearlWhite,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(children: [
                                  InkWell(
                                    onTap: () {
                                      if (tableController
                                              .showPhoneandEmail.value ==
                                          false) {
                                        tableController.setToTrue(
                                            tableController.showPhoneandEmail);
                                      } else {
                                        tableController.setToFalse(
                                            tableController.showPhoneandEmail);
                                      }
                                    },
                                    child:
                                        const Icon(Icons.keyboard_arrow_down),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Contact Information",
                                    style: kEditLeadTextH1,
                                  ),
                                ]),
                              ),
                              Obx(() => tableController
                                          .showPhoneandEmail.value ==
                                      true
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 180,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  initialValue: recordController
                                                      .isStringDataNull(tableController
                                                          .getRecordByFieldType(
                                                              kPhoneNumber,
                                                              argumentRecordList)
                                                          .data),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets.all(0),
                                                    labelText: "Phone",
                                                    labelStyle: kEditLeadTextH2,
                                                  ),
                                                  validator: (String? value) {
                                                    return recordController
                                                        .isPhoneNumberValid(
                                                            value);
                                                  },
                                                  onSaved: (value) {
                                                    // Check if the data has changed before updating the database
                                                    if (tableController
                                                            .getRecordByFieldType(
                                                                kPhoneNumber,
                                                                argumentRecordList)
                                                            .data !=
                                                        value.toString()) {
                                                      // Adds an RecordUpdate in the the list of updates
                                                      // RecordUpdate class allows us to track the changes we did in the user's information
                                                      recordUpdateController.createRecordUpdate(
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  kPhoneNumber,
                                                                  argumentRecordList)
                                                              .userId,
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  kPhoneNumber,
                                                                  argumentRecordList)
                                                              .type,
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  kPhoneNumber,
                                                                  argumentRecordList)
                                                              .data,
                                                          value.toString());

                                                      // Change the data of the record based on the given field type
                                                      tableController
                                                          .getRecordByFieldType(
                                                              kPhoneNumber,
                                                              argumentRecordList)
                                                          .data = value.toString();

                                                      // Add the updated record to the list of updated records
                                                      recordController
                                                          .recordsToUpdate
                                                          .add(tableController
                                                              .getRecordByFieldType(
                                                                  kPhoneNumber,
                                                                  argumentRecordList));
                                                    }
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 30),
                                              Expanded(
                                                child: TextFormField(
                                                  initialValue: recordController
                                                      .isStringDataNull(tableController
                                                          .getRecordByFieldType(
                                                              kEmail,
                                                              argumentRecordList)
                                                          .data),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets.all(0),
                                                    labelText: "Email",
                                                    labelStyle: kEditLeadTextH2,
                                                  ),
                                                  validator: (String? value) {
                                                    return recordController
                                                        .isEmailValid(value);
                                                  },
                                                  onSaved: (value) {
                                                    // Check if the data has changed before updating the database
                                                    if (tableController
                                                            .getRecordByFieldType(
                                                                kEmail,
                                                                argumentRecordList)
                                                            .data !=
                                                        value.toString()) {
                                                      // Adds an RecordUpdate in the the list of updates
                                                      // RecordUpdate class allows us to track the changes we did in the user's information
                                                      recordUpdateController.createRecordUpdate(
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  kEmail,
                                                                  argumentRecordList)
                                                              .userId,
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  kEmail,
                                                                  argumentRecordList)
                                                              .type,
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  kEmail,
                                                                  argumentRecordList)
                                                              .data,
                                                          value.toString());

                                                      // Change the data of the record based on the given field type
                                                      tableController
                                                          .getRecordByFieldType(
                                                              kEmail,
                                                              argumentRecordList)
                                                          .data = value.toString();

                                                      // Add the updated record to the list of updated records
                                                      recordController
                                                          .recordsToUpdate
                                                          .add(tableController
                                                              .getRecordByFieldType(
                                                                  kEmail,
                                                                  argumentRecordList));
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: 895,
                                            child: TextFormField(
                                              initialValue: recordController
                                                  .isStringDataNull(
                                                      tableController
                                                          .getRecordByFieldType(
                                                              kMobileNumber,
                                                              argumentRecordList)
                                                          .data),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                labelText: "Mobile",
                                                labelStyle: kEditLeadTextH2,
                                              ),
                                              validator: (String? value) {
                                                return recordController
                                                    .isPhoneNumberValid(value);
                                              },
                                              onSaved: (value) {
                                                // Check if the data has changed before updating the database
                                                if (tableController
                                                        .getRecordByFieldType(
                                                            kMobileNumber,
                                                            argumentRecordList)
                                                        .data !=
                                                    value.toString()) {
                                                  // Adds an RecordUpdate in the the list of updates
                                                  // RecordUpdate class allows us to track the changes we did in the user's information
                                                  recordUpdateController.createRecordUpdate(
                                                      tableController
                                                          .getRecordByFieldType(
                                                              kMobileNumber,
                                                              argumentRecordList)
                                                          .userId,
                                                      tableController
                                                          .getRecordByFieldType(
                                                              kMobileNumber,
                                                              argumentRecordList)
                                                          .type,
                                                      tableController
                                                          .getRecordByFieldType(
                                                              kMobileNumber,
                                                              argumentRecordList)
                                                          .data,
                                                      value.toString());

                                                  // Change the data of the record based on the given field type
                                                  tableController
                                                      .getRecordByFieldType(
                                                          kMobileNumber,
                                                          argumentRecordList)
                                                      .data = value.toString();

                                                  // Add the updated record to the list of updated records
                                                  recordController
                                                      .recordsToUpdate
                                                      .add(tableController
                                                          .getRecordByFieldType(
                                                              kMobileNumber,
                                                              argumentRecordList));
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container())
                            ],
                          ),
                        ),
                        // Address Information
                        Container(
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: kColorPearlWhite,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(children: [
                                  InkWell(
                                    onTap: () {
                                      if (tableController
                                              .showAddressInfo.value ==
                                          false) {
                                        tableController.setToTrue(
                                            tableController.showAddressInfo);
                                      } else {
                                        tableController.setToFalse(
                                            tableController.showAddressInfo);
                                      }
                                    },
                                    child:
                                        const Icon(Icons.keyboard_arrow_down),
                                  ),
                                  Text(
                                    "Address Information",
                                    style: kEditLeadTextH1,
                                  ),
                                ]),
                              ),
                              Obx(() => tableController.showAddressInfo.value ==
                                      true
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 245,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10),
                                          TextFormField(
                                            initialValue: recordController
                                                .isStringDataNull(
                                                    tableController
                                                        .getRecordByFieldType(
                                                            kAddress1,
                                                            argumentRecordList)
                                                        .data),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              labelText: "Street Address 1",
                                              labelStyle: kEditLeadTextH2,
                                            ),
                                            validator: (String? value) {
                                              return recordController
                                                  .isStringEmpty(value);
                                            },
                                            onSaved: (value) {
                                              // Check if the data has changed before updating the database
                                              if (tableController
                                                      .getRecordByFieldType(
                                                          kAddress1,
                                                          argumentRecordList)
                                                      .data !=
                                                  value.toString()) {
                                                // Adds an RecordUpdate in the the list of updates
                                                // RecordUpdate class allows us to track the changes we did in the user's information
                                                recordUpdateController.createRecordUpdate(
                                                    tableController
                                                        .getRecordByFieldType(
                                                            kAddress1,
                                                            argumentRecordList)
                                                        .userId,
                                                    tableController
                                                        .getRecordByFieldType(
                                                            kAddress1,
                                                            argumentRecordList)
                                                        .type,
                                                    tableController
                                                        .getRecordByFieldType(
                                                            kAddress1,
                                                            argumentRecordList)
                                                        .data,
                                                    value.toString());

                                                // Change the data of the record based on the given field type
                                                tableController
                                                    .getRecordByFieldType(
                                                        kAddress1,
                                                        argumentRecordList)
                                                    .data = value.toString();

                                                // Add the updated record to the list of updated records
                                                recordController.recordsToUpdate
                                                    .add(tableController
                                                        .getRecordByFieldType(
                                                            kAddress1,
                                                            argumentRecordList));
                                              }
                                            },
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  initialValue: recordController
                                                      .isStringDataNull(tableController
                                                          .getRecordByFieldType(
                                                              kCity,
                                                              argumentRecordList)
                                                          .data),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets.all(0),
                                                    labelText: "City",
                                                    labelStyle: kEditLeadTextH2,
                                                  ),
                                                  validator: (String? value) {
                                                    return recordController
                                                        .isStringEmpty(value);
                                                  },
                                                  onSaved: (value) {
                                                    // Check is the data has changed before updating the database
                                                    if (tableController
                                                            .getRecordByFieldType(
                                                                kCity,
                                                                argumentRecordList)
                                                            .data !=
                                                        value.toString()) {
                                                      // Adds an RecordUpdate in the the list of updates
                                                      // RecordUpdate class allows us to track the changes we did in the user's information
                                                      recordUpdateController.createRecordUpdate(
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  kCity,
                                                                  argumentRecordList)
                                                              .userId,
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  kCity,
                                                                  argumentRecordList)
                                                              .type,
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  kCity,
                                                                  argumentRecordList)
                                                              .data,
                                                          value.toString());

                                                      // Change the data of the record based on the given field type
                                                      tableController
                                                          .getRecordByFieldType(
                                                              kCity,
                                                              argumentRecordList)
                                                          .data = value.toString();

                                                      // Add the updated record to the list of updated records
                                                      recordController
                                                          .recordsToUpdate
                                                          .add(tableController
                                                              .getRecordByFieldType(
                                                                  kCity,
                                                                  argumentRecordList));
                                                    }
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 30),
                                              Expanded(
                                                child: TextFormField(
                                                  initialValue: recordController
                                                      .isStringDataNull(tableController
                                                          .getRecordByFieldType(
                                                              kProvince,
                                                              argumentRecordList)
                                                          .data),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets.all(0),
                                                    labelText: "Province",
                                                    labelStyle: kEditLeadTextH2,
                                                  ),
                                                  validator: (String? value) {
                                                    return recordController
                                                        .isStringEmpty(value);
                                                  },
                                                  onSaved: (value) {
                                                    // Check if the data has changed before updating the database
                                                    if (tableController
                                                            .getRecordByFieldType(
                                                                kProvince,
                                                                argumentRecordList)
                                                            .data !=
                                                        value.toString()) {
                                                      // Adds an RecordUpdate in the the list of updates
                                                      // RecordUpdate class allows us to track the changes we did in the user's information
                                                      recordUpdateController.createRecordUpdate(
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  kProvince,
                                                                  argumentRecordList)
                                                              .userId,
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  kProvince,
                                                                  argumentRecordList)
                                                              .type,
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  kProvince,
                                                                  argumentRecordList)
                                                              .data,
                                                          value.toString());

                                                      // Change the data of the record based on the given field type
                                                      tableController
                                                          .getRecordByFieldType(
                                                              kProvince,
                                                              argumentRecordList)
                                                          .data = value.toString();

                                                      // Add the updated record to the list of updated records
                                                      recordController
                                                          .recordsToUpdate
                                                          .add(tableController
                                                              .getRecordByFieldType(
                                                                  kProvince,
                                                                  argumentRecordList));
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: 895,
                                            child: TextFormField(
                                              initialValue: recordController
                                                  .isStringDataNull(
                                                      tableController
                                                          .getRecordByFieldType(
                                                              kPostal,
                                                              argumentRecordList)
                                                          .data),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                labelText: "Postal Code",
                                                labelStyle: kEditLeadTextH2,
                                              ),
                                              validator: (String? value) {
                                                return recordController
                                                    .isStringEmpty(value);
                                              },
                                              onSaved: (value) {
                                                // Check if the data has changed before updating the database
                                                if (tableController
                                                        .getRecordByFieldType(
                                                            kPostal,
                                                            argumentRecordList)
                                                        .data !=
                                                    value.toString()) {
                                                  // Adds an RecordUpdate in the the list of updates
                                                  // RecordUpdate class allows us to track the changes we did in the user's information
                                                  recordUpdateController.createRecordUpdate(
                                                      tableController
                                                          .getRecordByFieldType(
                                                              kPostal,
                                                              argumentRecordList)
                                                          .userId,
                                                      tableController
                                                          .getRecordByFieldType(
                                                              kPostal,
                                                              argumentRecordList)
                                                          .type,
                                                      tableController
                                                          .getRecordByFieldType(
                                                              kPostal,
                                                              argumentRecordList)
                                                          .data,
                                                      value.toString());

                                                  // Change the data of the record based on the given field type
                                                  tableController
                                                      .getRecordByFieldType(
                                                          kPostal,
                                                          argumentRecordList)
                                                      .data = value.toString();

                                                  // Add the updated record to the list of updated records
                                                  recordController
                                                      .recordsToUpdate
                                                      .add(tableController
                                                          .getRecordByFieldType(
                                                              kPostal,
                                                              argumentRecordList));
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container())
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Cancel and save button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Get.offAllNamed(kToLeadDetails, arguments: {
                                  'records': argumentRecordList,
                                  'progressDataList': argumentProgressList,
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white),
                              child: Text("Cancel", style: kButtonText2),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                if (recordController.validateTextField(
                                    recordController.updateFormKey)) {
                                  // Change the value of the ratings
                                  tableController
                                          .getRecordByFieldType(
                                              "ratings", argumentRecordList)
                                          .data =
                                      recordController.rating.value.toString();

                                  // Add the record with the rating to the list of records that we are updating
                                  recordController.recordsToUpdate.add(
                                      tableController.getRecordByFieldType(
                                          "ratings", argumentRecordList));

                                  // Update all the records
                                  recordController.updateRecord();

                                  // Insert all the updates in the database to keep track of all the changes
                                  recordUpdateController.insertAllUdpates();

                                  AwesomeDialog(
                                    context: context,
                                    width: 370,
                                    animType: AnimType.SCALE,
                                    headerAnimationLoop: false,
                                    dialogType: DialogType.SUCCES,
                                    title: 'Record Updated Successfully',
                                    btnOkOnPress: () {
                                      // Go back to Lead page
                                      Get.offAllNamed(kToLead);
                                    },
                                    btnOkIcon: Icons.check_circle,
                                    onDissmissCallback: (type) {},
                                  ).show();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: kColorDarkBlue),
                              child: Text("Save", style: kButtonText3),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:awesome_dialog/awesome_dialog.dart';
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
                                allowHalfRating: true,
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
                                                      "firstName",
                                                      argumentRecordList)
                                                  .data,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                labelText: "First Name",
                                                labelStyle: kEditLeadTextH2,
                                              ),
                                              validator: (String? value) {
                                                if (value.toString().isEmpty) {
                                                  return 'This field is required';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                // Check if the data has changed before updating the database
                                                if (tableController
                                                        .getRecordByFieldType(
                                                            "firstName",
                                                            argumentRecordList)
                                                        .data !=
                                                    value.toString()) {
                                                  // Adds an RecordUpdate in the the list of updates
                                                  // RecordUpdate class allows us to track the changes we did in the user's information
                                                  recordUpdateController.createRecordUpdate(
                                                      tableController
                                                          .getRecordByFieldType(
                                                              "firstName",
                                                              argumentRecordList)
                                                          .userId,
                                                      tableController
                                                          .getRecordByFieldType(
                                                              "firstName",
                                                              argumentRecordList)
                                                          .type,
                                                      tableController
                                                          .getRecordByFieldType(
                                                              "firstName",
                                                              argumentRecordList)
                                                          .data,
                                                      value.toString());

                                                  // Change the data of the record based on the given field type
                                                  tableController
                                                      .getRecordByFieldType(
                                                          "firstName",
                                                          argumentRecordList)
                                                      .data = value.toString();

                                                  // Add the updated record to the list of updated records
                                                  recordController
                                                      .recordsToUpdate
                                                      .add(tableController
                                                          .getRecordByFieldType(
                                                              "firstName",
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
                                                      "lastName",
                                                      argumentRecordList)
                                                  .data,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                labelText: "Last Name",
                                                labelStyle: kEditLeadTextH2,
                                              ),
                                              validator: (String? value) {
                                                if (value.toString().isEmpty) {
                                                  return 'This field is required';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                // Check if the data has changed before updating the database
                                                if (tableController
                                                        .getRecordByFieldType(
                                                            "lastName",
                                                            argumentRecordList)
                                                        .data !=
                                                    value.toString()) {
                                                  // Adds an RecordUpdate in the the list of updates
                                                  // RecordUpdate class allows us to track the changes we did in the user's information
                                                  recordUpdateController.createRecordUpdate(
                                                      tableController
                                                          .getRecordByFieldType(
                                                              "lastName",
                                                              argumentRecordList)
                                                          .userId,
                                                      tableController
                                                          .getRecordByFieldType(
                                                              "lastName",
                                                              argumentRecordList)
                                                          .type,
                                                      tableController
                                                          .getRecordByFieldType(
                                                              "lastName",
                                                              argumentRecordList)
                                                          .data,
                                                      value.toString());

                                                  // Change the data of the record based on the given field type
                                                  tableController
                                                      .getRecordByFieldType(
                                                          "lastName",
                                                          argumentRecordList)
                                                      .data = value.toString();

                                                  // Add the updated record to the list of updated records
                                                  recordController
                                                      .recordsToUpdate
                                                      .add(tableController
                                                          .getRecordByFieldType(
                                                              "lastName",
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
                                                              "phoneNumber",
                                                              argumentRecordList)
                                                          .data),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets.all(0),
                                                    labelText: "Phone",
                                                    labelStyle: kEditLeadTextH2,
                                                  ),
                                                  validator: (String? value) {
                                                    if (value
                                                        .toString()
                                                        .isEmpty) {
                                                      return 'This field is required';
                                                    }
                                                    if (!RegExp(
                                                            r"^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$")
                                                        .hasMatch(
                                                            value.toString())) {
                                                      return "Please enter a valid phone number";
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (value) {
                                                    // Check if the data has changed before updating the database
                                                    if (tableController
                                                            .getRecordByFieldType(
                                                                "phoneNumber",
                                                                argumentRecordList)
                                                            .data !=
                                                        value.toString()) {
                                                      // Adds an RecordUpdate in the the list of updates
                                                      // RecordUpdate class allows us to track the changes we did in the user's information
                                                      recordUpdateController.createRecordUpdate(
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  "phoneNumber",
                                                                  argumentRecordList)
                                                              .userId,
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  "phoneNumber",
                                                                  argumentRecordList)
                                                              .type,
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  "phoneNumber",
                                                                  argumentRecordList)
                                                              .data,
                                                          value.toString());

                                                      // Change the data of the record based on the given field type
                                                      tableController
                                                          .getRecordByFieldType(
                                                              "phoneNumber",
                                                              argumentRecordList)
                                                          .data = value.toString();

                                                      // Add the updated record to the list of updated records
                                                      recordController
                                                          .recordsToUpdate
                                                          .add(tableController
                                                              .getRecordByFieldType(
                                                                  "phoneNumber",
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
                                                              "email",
                                                              argumentRecordList)
                                                          .data),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets.all(0),
                                                    labelText: "Email",
                                                    labelStyle: kEditLeadTextH2,
                                                  ),
                                                  validator: (String? value) {
                                                    if (value
                                                        .toString()
                                                        .isEmpty) {
                                                      return 'This field is required';
                                                    }

                                                    if (!RegExp(
                                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                        .hasMatch(
                                                            value.toString())) {
                                                      return "Please enter a valid email";
                                                    }

                                                    return null;
                                                  },
                                                  onSaved: (value) {
                                                    // Check if the data has changed before updating the database
                                                    if (tableController
                                                            .getRecordByFieldType(
                                                                "email",
                                                                argumentRecordList)
                                                            .data !=
                                                        value.toString()) {
                                                      // Adds an RecordUpdate in the the list of updates
                                                      // RecordUpdate class allows us to track the changes we did in the user's information
                                                      recordUpdateController.createRecordUpdate(
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  "email",
                                                                  argumentRecordList)
                                                              .userId,
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  "email",
                                                                  argumentRecordList)
                                                              .type,
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  "email",
                                                                  argumentRecordList)
                                                              .data,
                                                          value.toString());

                                                      // Change the data of the record based on the given field type
                                                      tableController
                                                          .getRecordByFieldType(
                                                              "email",
                                                              argumentRecordList)
                                                          .data = value.toString();

                                                      // Add the updated record to the list of updated records
                                                      recordController
                                                          .recordsToUpdate
                                                          .add(tableController
                                                              .getRecordByFieldType(
                                                                  "email",
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
                                                              "mobileNumber",
                                                              argumentRecordList)
                                                          .data),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                labelText: "Mobile",
                                                labelStyle: kEditLeadTextH2,
                                              ),
                                              validator: (String? value) {
                                                if (value.toString().isEmpty) {
                                                  return 'This field is required';
                                                }

                                                if (!RegExp(
                                                        r"^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$")
                                                    .hasMatch(
                                                        value.toString())) {
                                                  return "Please enter a valid phone number";
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                // Check if the data has changed before updating the database
                                                if (tableController
                                                        .getRecordByFieldType(
                                                            "mobileNumber",
                                                            argumentRecordList)
                                                        .data !=
                                                    value.toString()) {
                                                  // Adds an RecordUpdate in the the list of updates
                                                  // RecordUpdate class allows us to track the changes we did in the user's information
                                                  recordUpdateController.createRecordUpdate(
                                                      tableController
                                                          .getRecordByFieldType(
                                                              "mobileNumber",
                                                              argumentRecordList)
                                                          .userId,
                                                      tableController
                                                          .getRecordByFieldType(
                                                              "mobileNumber",
                                                              argumentRecordList)
                                                          .type,
                                                      tableController
                                                          .getRecordByFieldType(
                                                              "mobileNumber",
                                                              argumentRecordList)
                                                          .data,
                                                      value.toString());

                                                  // Change the data of the record based on the given field type
                                                  tableController
                                                      .getRecordByFieldType(
                                                          "mobileNumber",
                                                          argumentRecordList)
                                                      .data = value.toString();

                                                  // Add the updated record to the list of updated records
                                                  recordController
                                                      .recordsToUpdate
                                                      .add(tableController
                                                          .getRecordByFieldType(
                                                              "mobileNumber",
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
                                                            "address1",
                                                            argumentRecordList)
                                                        .data),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              labelText: "Street Address 1",
                                              labelStyle: kEditLeadTextH2,
                                            ),
                                            validator: (String? value) {
                                              if (value.toString().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              // Check if the data has changed before updating the database
                                              if (tableController
                                                      .getRecordByFieldType(
                                                          "address1",
                                                          argumentRecordList)
                                                      .data !=
                                                  value.toString()) {
                                                // Adds an RecordUpdate in the the list of updates
                                                // RecordUpdate class allows us to track the changes we did in the user's information
                                                recordUpdateController.createRecordUpdate(
                                                    tableController
                                                        .getRecordByFieldType(
                                                            "address1",
                                                            argumentRecordList)
                                                        .userId,
                                                    tableController
                                                        .getRecordByFieldType(
                                                            "address1",
                                                            argumentRecordList)
                                                        .type,
                                                    tableController
                                                        .getRecordByFieldType(
                                                            "address1",
                                                            argumentRecordList)
                                                        .data,
                                                    value.toString());

                                                // Change the data of the record based on the given field type
                                                tableController
                                                    .getRecordByFieldType(
                                                        "address1",
                                                        argumentRecordList)
                                                    .data = value.toString();

                                                // Add the updated record to the list of updated records
                                                recordController.recordsToUpdate
                                                    .add(tableController
                                                        .getRecordByFieldType(
                                                            "address1",
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
                                                              "city",
                                                              argumentRecordList)
                                                          .data),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets.all(0),
                                                    labelText: "City",
                                                    labelStyle: kEditLeadTextH2,
                                                  ),
                                                  validator: (String? value) {
                                                    if (value
                                                        .toString()
                                                        .isEmpty) {
                                                      return 'This field is required';
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (value) {
                                                    // Check is the data has changed before updating the database
                                                    if (tableController
                                                            .getRecordByFieldType(
                                                                "city",
                                                                argumentRecordList)
                                                            .data !=
                                                        value.toString()) {
                                                      // Adds an RecordUpdate in the the list of updates
                                                      // RecordUpdate class allows us to track the changes we did in the user's information
                                                      recordUpdateController.createRecordUpdate(
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  "city",
                                                                  argumentRecordList)
                                                              .userId,
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  "city",
                                                                  argumentRecordList)
                                                              .type,
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  "city",
                                                                  argumentRecordList)
                                                              .data,
                                                          value.toString());

                                                      // Change the data of the record based on the given field type
                                                      tableController
                                                          .getRecordByFieldType(
                                                              "city",
                                                              argumentRecordList)
                                                          .data = value.toString();

                                                      // Add the updated record to the list of updated records
                                                      recordController
                                                          .recordsToUpdate
                                                          .add(tableController
                                                              .getRecordByFieldType(
                                                                  "city",
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
                                                              "province",
                                                              argumentRecordList)
                                                          .data),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets.all(0),
                                                    labelText: "Province",
                                                    labelStyle: kEditLeadTextH2,
                                                  ),
                                                  validator: (String? value) {
                                                    if (value
                                                        .toString()
                                                        .isEmpty) {
                                                      return 'This field is required';
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (value) {
                                                    // Check if the data has changed before updating the database
                                                    if (tableController
                                                            .getRecordByFieldType(
                                                                "province",
                                                                argumentRecordList)
                                                            .data !=
                                                        value.toString()) {
                                                      // Adds an RecordUpdate in the the list of updates
                                                      // RecordUpdate class allows us to track the changes we did in the user's information
                                                      recordUpdateController.createRecordUpdate(
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  "province",
                                                                  argumentRecordList)
                                                              .userId,
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  "province",
                                                                  argumentRecordList)
                                                              .type,
                                                          tableController
                                                              .getRecordByFieldType(
                                                                  "province",
                                                                  argumentRecordList)
                                                              .data,
                                                          value.toString());

                                                      // Change the data of the record based on the given field type
                                                      tableController
                                                          .getRecordByFieldType(
                                                              "province",
                                                              argumentRecordList)
                                                          .data = value.toString();

                                                      // Add the updated record to the list of updated records
                                                      recordController
                                                          .recordsToUpdate
                                                          .add(tableController
                                                              .getRecordByFieldType(
                                                                  "province",
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
                                                              "postal",
                                                              argumentRecordList)
                                                          .data),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                labelText: "Postal Code",
                                                labelStyle: kEditLeadTextH2,
                                              ),
                                              validator: (String? value) {
                                                if (value.toString().isEmpty) {
                                                  return 'This field is required';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                // Check if the data has changed before updating the database
                                                if (tableController
                                                        .getRecordByFieldType(
                                                            "postal",
                                                            argumentRecordList)
                                                        .data !=
                                                    value.toString()) {
                                                  // Adds an RecordUpdate in the the list of updates
                                                  // RecordUpdate class allows us to track the changes we did in the user's information
                                                  recordUpdateController.createRecordUpdate(
                                                      tableController
                                                          .getRecordByFieldType(
                                                              "postal",
                                                              argumentRecordList)
                                                          .userId,
                                                      tableController
                                                          .getRecordByFieldType(
                                                              "postal",
                                                              argumentRecordList)
                                                          .type,
                                                      tableController
                                                          .getRecordByFieldType(
                                                              "postal",
                                                              argumentRecordList)
                                                          .data,
                                                      value.toString());

                                                  // Change the data of the record based on the given field type
                                                  tableController
                                                      .getRecordByFieldType(
                                                          "postal",
                                                          argumentRecordList)
                                                      .data = value.toString();

                                                  // Add the updated record to the list of updated records
                                                  recordController
                                                      .recordsToUpdate
                                                      .add(tableController
                                                          .getRecordByFieldType(
                                                              "postal",
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
                                Get.offAllNamed("/LeadDetails", arguments: {
                                  'records': argumentRecordList,
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
                                      Get.offAllNamed("/Leads");
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

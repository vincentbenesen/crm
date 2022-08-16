import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:crm/Controllers/record_controller.dart';
import 'package:crm/Controllers/table_controller.dart';
import 'package:crm/Widgets/navbar.dart';

import '../Models/record.dart';

class EditLeads extends StatelessWidget {
  const EditLeads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 56, 91, 133),
      body: Form(
        key: Get.find<RecordController>().updateFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Navbar(),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                height: 650,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  child: Column(
                    children: [
                      // Details
                      Container(
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 219, 217, 217),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(children: [
                                InkWell(
                                  onTap: () {
                                    if (Get.find<TableController>()
                                            .showContactInfo
                                            .value ==
                                        false) {
                                      Get.find<TableController>().setToTrue(
                                          Get.find<TableController>()
                                              .showContactInfo);
                                    } else {
                                      Get.find<TableController>().setToFalse(
                                          Get.find<TableController>()
                                              .showContactInfo);
                                    }
                                  },
                                  child: const Icon(Icons.keyboard_arrow_down),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Details",
                                  style: GoogleFonts.rubik(fontSize: 15),
                                ),
                              ]),
                            ),
                            Obx(() => Get.find<TableController>()
                                        .showContactInfo
                                        .value ==
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
                                            initialValue: Get.find<
                                                    TableController>()
                                                .getRecordByFieldType(
                                                    "firstName",
                                                    Get.arguments['records'])
                                                .data,
                                            decoration: InputDecoration(
                                              labelText: "First Name",
                                              labelStyle: GoogleFonts.rubik(
                                                  fontSize: 15),
                                            ),
                                            validator: (String? value) {
                                              if (value.toString().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              // Check is the data has changed before updating the database
                                              if (Get.find<TableController>()
                                                      .getRecordByFieldType(
                                                          "firstName",
                                                          Get.arguments[
                                                              'records'])
                                                      .data !=
                                                  value.toString()) {
                                                // Change the data of the record based on the given field type
                                                Get.find<TableController>()
                                                    .getRecordByFieldType(
                                                        "firstName",
                                                        Get.arguments[
                                                            'records'])
                                                    .data = value.toString();

                                                // Add the updated record to the list of updated records
                                                Get.find<RecordController>()
                                                    .recordsToUpdate
                                                    .add(Get.find<
                                                            TableController>()
                                                        .getRecordByFieldType(
                                                            "firstName",
                                                            Get.arguments[
                                                                'records']));
                                              }
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 30),
                                        Expanded(
                                          child: TextFormField(
                                            initialValue: Get.find<
                                                    TableController>()
                                                .getRecordByFieldType(
                                                    "lastName",
                                                    Get.arguments['records'])
                                                .data,
                                            // '',
                                            decoration: InputDecoration(
                                              labelText: "Last Name",
                                              labelStyle: GoogleFonts.rubik(
                                                  fontSize: 15),
                                            ),
                                            validator: (String? value) {
                                              if (value.toString().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              // Check is the data has changed before updating the database
                                              if (Get.find<TableController>()
                                                      .getRecordByFieldType(
                                                          "lastName",
                                                          Get.arguments[
                                                              'records'])
                                                      .data !=
                                                  value.toString()) {
                                                // Change the data of the record based on the given field type
                                                Get.find<TableController>()
                                                    .getRecordByFieldType(
                                                        "lastName",
                                                        Get.arguments[
                                                            'records'])
                                                    .data = value.toString();

                                                // Add the updated record to the list of updated records
                                                Get.find<RecordController>()
                                                    .recordsToUpdate
                                                    .add(Get.find<
                                                            TableController>()
                                                        .getRecordByFieldType(
                                                            "lastName",
                                                            Get.arguments[
                                                                'records']));
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
                                color: const Color.fromARGB(255, 219, 217, 217),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(children: [
                                InkWell(
                                  onTap: () {
                                    if (Get.find<TableController>()
                                            .showPhoneandEmail
                                            .value ==
                                        false) {
                                      Get.find<TableController>().setToTrue(
                                          Get.find<TableController>()
                                              .showPhoneandEmail);
                                    } else {
                                      Get.find<TableController>().setToFalse(
                                          Get.find<TableController>()
                                              .showPhoneandEmail);
                                    }
                                  },
                                  child: const Icon(Icons.keyboard_arrow_down),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Contact Information",
                                  style: GoogleFonts.rubik(fontSize: 15),
                                ),
                              ]),
                            ),
                            Obx(() => Get.find<TableController>()
                                        .showPhoneandEmail
                                        .value ==
                                    true
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 150,
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
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                initialValue:
                                                    Get.find<TableController>()
                                                        .getRecordByFieldType(
                                                            "phoneNumber",
                                                            Get.arguments[
                                                                'records'])
                                                        .data,
                                                decoration: InputDecoration(
                                                  labelText: "Phone",
                                                  labelStyle: GoogleFonts.rubik(
                                                      fontSize: 15),
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
                                                  // Check is the data has changed before updating the database
                                                  if (Get.find<
                                                              TableController>()
                                                          .getRecordByFieldType(
                                                              "phoneNumber",
                                                              Get.arguments[
                                                                  'records'])
                                                          .data !=
                                                      value.toString()) {
                                                    // Change the data of the record based on the given field type
                                                    Get.find<TableController>()
                                                        .getRecordByFieldType(
                                                            "phoneNumber",
                                                            Get.arguments[
                                                                'records'])
                                                        .data = value.toString();

                                                    // Add the updated record to the list of updated records
                                                    Get.find<RecordController>()
                                                        .recordsToUpdate
                                                        .add(Get.find<
                                                                TableController>()
                                                            .getRecordByFieldType(
                                                                "phoneNumber",
                                                                Get.arguments[
                                                                    'records']));
                                                  }
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 30),
                                            Expanded(
                                              child: TextFormField(
                                                initialValue:
                                                    Get.find<TableController>()
                                                        .getRecordByFieldType(
                                                            "email",
                                                            Get.arguments[
                                                                'records'])
                                                        .data,
                                                decoration: InputDecoration(
                                                  labelText: "Email",
                                                  labelStyle: GoogleFonts.rubik(
                                                      fontSize: 15),
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
                                                  // Check is the data has changed before updating the database
                                                  if (Get.find<
                                                              TableController>()
                                                          .getRecordByFieldType(
                                                              "email",
                                                              Get.arguments[
                                                                  'records'])
                                                          .data !=
                                                      value.toString()) {
                                                    // Change the data of the record based on the given field type
                                                    Get.find<TableController>()
                                                        .getRecordByFieldType(
                                                            "email",
                                                            Get.arguments[
                                                                'records'])
                                                        .data = value.toString();

                                                    // Add the updated record to the list of updated records
                                                    Get.find<RecordController>()
                                                        .recordsToUpdate
                                                        .add(Get.find<
                                                                TableController>()
                                                            .getRecordByFieldType(
                                                                "email",
                                                                Get.arguments[
                                                                    'records']));
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 895,
                                          child: TextFormField(
                                            initialValue: Get.find<
                                                    TableController>()
                                                .getRecordByFieldType(
                                                    "mobileNumber",
                                                    Get.arguments['records'])
                                                .data,
                                            decoration: InputDecoration(
                                              labelText: "Mobile",
                                              labelStyle: GoogleFonts.rubik(
                                                  fontSize: 15),
                                            ),
                                            validator: (String? value) {
                                              if (value.toString().isEmpty) {
                                                return 'This field is required';
                                              }

                                              if (!RegExp(
                                                      r"^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$")
                                                  .hasMatch(value.toString())) {
                                                return "Please enter a valid phone number";
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              // Check is the data has changed before updating the database
                                              if (Get.find<TableController>()
                                                      .getRecordByFieldType(
                                                          "mobileNumber",
                                                          Get.arguments[
                                                              'records'])
                                                      .data !=
                                                  value.toString()) {
                                                // Change the data of the record based on the given field type
                                                Get.find<TableController>()
                                                    .getRecordByFieldType(
                                                        "mobileNumber",
                                                        Get.arguments[
                                                            'records'])
                                                    .data = value.toString();

                                                // Add the updated record to the list of updated records
                                                Get.find<RecordController>()
                                                    .recordsToUpdate
                                                    .add(Get.find<
                                                            TableController>()
                                                        .getRecordByFieldType(
                                                            "mobileNumber",
                                                            Get.arguments[
                                                                'records']));
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
                      // Address Information
                      Container(
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 219, 217, 217),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(children: [
                                InkWell(
                                  onTap: () {
                                    if (Get.find<TableController>()
                                            .showAddressInfo
                                            .value ==
                                        false) {
                                      Get.find<TableController>().setToTrue(
                                          Get.find<TableController>()
                                              .showAddressInfo);
                                    } else {
                                      Get.find<TableController>().setToFalse(
                                          Get.find<TableController>()
                                              .showAddressInfo);
                                    }
                                  },
                                  child: const Icon(Icons.keyboard_arrow_down),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Address Information",
                                  style: GoogleFonts.rubik(fontSize: 15),
                                ),
                              ]),
                            ),
                            Obx(() => Get.find<TableController>()
                                        .showAddressInfo
                                        .value ==
                                    true
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 225,
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
                                        TextFormField(
                                          initialValue:
                                              Get.find<TableController>()
                                                  .getRecordByFieldType(
                                                      "address1",
                                                      Get.arguments['records'])
                                                  .data,
                                          decoration: InputDecoration(
                                            labelText: "Street Address 1",
                                            labelStyle:
                                                GoogleFonts.rubik(fontSize: 15),
                                          ),
                                          validator: (String? value) {
                                            if (value.toString().isEmpty) {
                                              return 'This field is required';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            // Check is the data has changed before updating the database
                                            if (Get.find<TableController>()
                                                    .getRecordByFieldType(
                                                        "address1",
                                                        Get.arguments[
                                                            'records'])
                                                    .data !=
                                                value.toString()) {
                                              // Change the data of the record based on the given field type
                                              Get.find<TableController>()
                                                  .getRecordByFieldType(
                                                      "address1",
                                                      Get.arguments['records'])
                                                  .data = value.toString();

                                              // Add the updated record to the list of updated records
                                              Get.find<RecordController>()
                                                  .recordsToUpdate
                                                  .add(Get.find<
                                                          TableController>()
                                                      .getRecordByFieldType(
                                                          "address1",
                                                          Get.arguments[
                                                              'records']));
                                            }
                                          },
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                initialValue:
                                                    Get.find<TableController>()
                                                        .getRecordByFieldType(
                                                            "city",
                                                            Get.arguments[
                                                                'records'])
                                                        .data,
                                                decoration: InputDecoration(
                                                  labelText: "City",
                                                  labelStyle: GoogleFonts.rubik(
                                                      fontSize: 15),
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
                                                  if (Get.find<
                                                              TableController>()
                                                          .getRecordByFieldType(
                                                              "city",
                                                              Get.arguments[
                                                                  'records'])
                                                          .data !=
                                                      value.toString()) {
                                                    // Change the data of the record based on the given field type
                                                    Get.find<TableController>()
                                                        .getRecordByFieldType(
                                                            "city",
                                                            Get.arguments[
                                                                'records'])
                                                        .data = value.toString();

                                                    // Add the updated record to the list of updated records
                                                    Get.find<RecordController>()
                                                        .recordsToUpdate
                                                        .add(Get.find<
                                                                TableController>()
                                                            .getRecordByFieldType(
                                                                "city",
                                                                Get.arguments[
                                                                    'records']));
                                                  }
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 30),
                                            Expanded(
                                              child: TextFormField(
                                                initialValue:
                                                    Get.find<TableController>()
                                                        .getRecordByFieldType(
                                                            "province",
                                                            Get.arguments[
                                                                'records'])
                                                        .data,
                                                decoration: InputDecoration(
                                                  labelText: "Province",
                                                  labelStyle: GoogleFonts.rubik(
                                                      fontSize: 15),
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
                                                  if (Get.find<
                                                              TableController>()
                                                          .getRecordByFieldType(
                                                              "province",
                                                              Get.arguments[
                                                                  'records'])
                                                          .data !=
                                                      value.toString()) {
                                                    // Change the data of the record based on the given field type
                                                    Get.find<TableController>()
                                                        .getRecordByFieldType(
                                                            "province",
                                                            Get.arguments[
                                                                'records'])
                                                        .data = value.toString();

                                                    // Add the updated record to the list of updated records
                                                    Get.find<RecordController>()
                                                        .recordsToUpdate
                                                        .add(Get.find<
                                                                TableController>()
                                                            .getRecordByFieldType(
                                                                "province",
                                                                Get.arguments[
                                                                    'records']));
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 895,
                                          child: TextFormField(
                                            initialValue: Get.find<
                                                    TableController>()
                                                .getRecordByFieldType("postal",
                                                    Get.arguments['records'])
                                                .data,
                                            decoration: InputDecoration(
                                              labelText: "Postal Code",
                                              labelStyle: GoogleFonts.rubik(
                                                  fontSize: 15),
                                            ),
                                            validator: (String? value) {
                                              if (value.toString().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              // Check is the data has changed before updating the database
                                              if (Get.find<TableController>()
                                                      .getRecordByFieldType(
                                                          "postal",
                                                          Get.arguments[
                                                              'records'])
                                                      .data !=
                                                  value.toString()) {
                                                // Change the data of the record based on the given field type
                                                Get.find<TableController>()
                                                    .getRecordByFieldType(
                                                        "postal",
                                                        Get.arguments[
                                                            'records'])
                                                    .data = value.toString();

                                                // Add the updated record to the list of updated records
                                                Get.find<RecordController>()
                                                    .recordsToUpdate
                                                    .add(Get.find<
                                                            TableController>()
                                                        .getRecordByFieldType(
                                                            "postal",
                                                            Get.arguments[
                                                                'records']));
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            onPressed: () {
                              Get.offAllNamed("/LeadDetails", arguments: {
                                'records': Get.arguments['records'],
                              });
                            },
                            color: Colors.white,
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.rubik(
                                  fontSize: 20,
                                  color:
                                      const Color.fromARGB(255, 56, 91, 133)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          RaisedButton(
                            onPressed: () {
                              if (Get.find<RecordController>()
                                  .validateTextField(
                                      Get.find<RecordController>()
                                          .updateFormKey)) {
                                Get.find<RecordController>().updateRecord();
                                // print(Get.find<RecordController>()
                                //     .recordsToUpdate
                                //     .toString());
                                Get.offAllNamed("/Leads");
                              }
                            },
                            color: const Color.fromARGB(255, 56, 91, 133),
                            child: Text("Save",
                                style: GoogleFonts.rubik(
                                    fontSize: 20, color: Colors.white)),
                          )
                        ],
                      )
                    ],
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

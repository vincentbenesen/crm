import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:crm/constant.dart';
import 'package:crm/Controllers/record_controller.dart';
import 'package:crm/Controllers/table_controller.dart';
import 'package:crm/Controllers/recordUpdate_controller.dart';
import 'package:crm/Widgets/navbar.dart';
import 'package:crm/Widgets/custom_AppBar.dart';

class EditLeads extends StatelessWidget {
  const EditLeads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      drawer: Navbar(),
      backgroundColor: kColorDarkBlue,
      body: Form(
        key: Get.find<RecordController>().updateFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: 690,
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
                                  color: kColorPearlWhite,
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
                                                if (Get.find<TableController>()
                                                        .getRecordByFieldType(
                                                            "firstName",
                                                            Get.arguments[
                                                                'records'])
                                                        .data !=
                                                    value.toString()) {
                                                  // Adds an RecordUpdate in the the list of updates
                                                  // RecordUpdate class allows us to track the changes we did in the user's information
                                                  Get.find<RecordUpdateController>().createRecordUpdate(
                                                      Get.find<
                                                              TableController>()
                                                          .getRecordByFieldType(
                                                              "firstName",
                                                              Get.arguments[
                                                                  'records'])
                                                          .userId,
                                                      Get.find<
                                                              TableController>()
                                                          .getRecordByFieldType(
                                                              "firstName",
                                                              Get.arguments[
                                                                  'records'])
                                                          .type,
                                                      Get.find<
                                                              TableController>()
                                                          .getRecordByFieldType(
                                                              "firstName",
                                                              Get.arguments[
                                                                  'records'])
                                                          .data,
                                                      value.toString());

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
                                                if (Get.find<TableController>()
                                                        .getRecordByFieldType(
                                                            "lastName",
                                                            Get.arguments[
                                                                'records'])
                                                        .data !=
                                                    value.toString()) {
                                                  // Adds an RecordUpdate in the the list of updates
                                                  // RecordUpdate class allows us to track the changes we did in the user's information
                                                  Get.find<RecordUpdateController>().createRecordUpdate(
                                                      Get.find<
                                                              TableController>()
                                                          .getRecordByFieldType(
                                                              "lastName",
                                                              Get.arguments[
                                                                  'records'])
                                                          .userId,
                                                      Get.find<
                                                              TableController>()
                                                          .getRecordByFieldType(
                                                              "lastName",
                                                              Get.arguments[
                                                                  'records'])
                                                          .type,
                                                      Get.find<
                                                              TableController>()
                                                          .getRecordByFieldType(
                                                              "lastName",
                                                              Get.arguments[
                                                                  'records'])
                                                          .data,
                                                      value.toString());

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
                                  color: kColorPearlWhite,
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
                              Obx(() => Get.find<TableController>()
                                          .showPhoneandEmail
                                          .value ==
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
                                                  initialValue: Get.find<
                                                          TableController>()
                                                      .getRecordByFieldType(
                                                          "phoneNumber",
                                                          Get.arguments[
                                                              'records'])
                                                      .data,
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
                                                    if (Get.find<
                                                                TableController>()
                                                            .getRecordByFieldType(
                                                                "phoneNumber",
                                                                Get.arguments[
                                                                    'records'])
                                                            .data !=
                                                        value.toString()) {
                                                      // Adds an RecordUpdate in the the list of updates
                                                      // RecordUpdate class allows us to track the changes we did in the user's information
                                                      Get.find<RecordUpdateController>().createRecordUpdate(
                                                          Get.find<
                                                                  TableController>()
                                                              .getRecordByFieldType(
                                                                  "phoneNumber",
                                                                  Get.arguments[
                                                                      'records'])
                                                              .userId,
                                                          Get.find<
                                                                  TableController>()
                                                              .getRecordByFieldType(
                                                                  "phoneNumber",
                                                                  Get.arguments[
                                                                      'records'])
                                                              .type,
                                                          Get.find<
                                                                  TableController>()
                                                              .getRecordByFieldType(
                                                                  "phoneNumber",
                                                                  Get.arguments[
                                                                      'records'])
                                                              .data,
                                                          value.toString());

                                                      // Change the data of the record based on the given field type
                                                      Get.find<
                                                              TableController>()
                                                          .getRecordByFieldType(
                                                              "phoneNumber",
                                                              Get.arguments[
                                                                  'records'])
                                                          .data = value.toString();

                                                      // Add the updated record to the list of updated records
                                                      Get.find<
                                                              RecordController>()
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
                                                  initialValue: Get.find<
                                                          TableController>()
                                                      .getRecordByFieldType(
                                                          "email",
                                                          Get.arguments[
                                                              'records'])
                                                      .data,
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
                                                    if (Get.find<
                                                                TableController>()
                                                            .getRecordByFieldType(
                                                                "email",
                                                                Get.arguments[
                                                                    'records'])
                                                            .data !=
                                                        value.toString()) {
                                                      // Adds an RecordUpdate in the the list of updates
                                                      // RecordUpdate class allows us to track the changes we did in the user's information
                                                      Get.find<RecordUpdateController>().createRecordUpdate(
                                                          Get.find<
                                                                  TableController>()
                                                              .getRecordByFieldType(
                                                                  "email",
                                                                  Get.arguments[
                                                                      'records'])
                                                              .userId,
                                                          Get.find<
                                                                  TableController>()
                                                              .getRecordByFieldType(
                                                                  "email",
                                                                  Get.arguments[
                                                                      'records'])
                                                              .type,
                                                          Get.find<
                                                                  TableController>()
                                                              .getRecordByFieldType(
                                                                  "email",
                                                                  Get.arguments[
                                                                      'records'])
                                                              .data,
                                                          value.toString());

                                                      // Change the data of the record based on the given field type
                                                      Get.find<
                                                              TableController>()
                                                          .getRecordByFieldType(
                                                              "email",
                                                              Get.arguments[
                                                                  'records'])
                                                          .data = value.toString();

                                                      // Add the updated record to the list of updated records
                                                      Get.find<
                                                              RecordController>()
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
                                          const SizedBox(height: 10),
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
                                                if (Get.find<TableController>()
                                                        .getRecordByFieldType(
                                                            "mobileNumber",
                                                            Get.arguments[
                                                                'records'])
                                                        .data !=
                                                    value.toString()) {
                                                  // Adds an RecordUpdate in the the list of updates
                                                  // RecordUpdate class allows us to track the changes we did in the user's information
                                                  Get.find<RecordUpdateController>().createRecordUpdate(
                                                      Get.find<
                                                              TableController>()
                                                          .getRecordByFieldType(
                                                              "mobileNumber",
                                                              Get.arguments[
                                                                  'records'])
                                                          .userId,
                                                      Get.find<
                                                              TableController>()
                                                          .getRecordByFieldType(
                                                              "mobileNumber",
                                                              Get.arguments[
                                                                  'records'])
                                                          .type,
                                                      Get.find<
                                                              TableController>()
                                                          .getRecordByFieldType(
                                                              "mobileNumber",
                                                              Get.arguments[
                                                                  'records'])
                                                          .data,
                                                      value.toString());

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
                                    child:
                                        const Icon(Icons.keyboard_arrow_down),
                                  ),
                                  Text(
                                    "Address Information",
                                    style: kEditLeadTextH1,
                                  ),
                                ]),
                              ),
                              Obx(() => Get.find<TableController>()
                                          .showAddressInfo
                                          .value ==
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
                                            initialValue: Get.find<
                                                    TableController>()
                                                .getRecordByFieldType(
                                                    "address1",
                                                    Get.arguments['records'])
                                                .data,
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
                                              if (Get.find<TableController>()
                                                      .getRecordByFieldType(
                                                          "address1",
                                                          Get.arguments[
                                                              'records'])
                                                      .data !=
                                                  value.toString()) {
                                                // Adds an RecordUpdate in the the list of updates
                                                // RecordUpdate class allows us to track the changes we did in the user's information
                                                Get.find<
                                                        RecordUpdateController>()
                                                    .createRecordUpdate(
                                                        Get.find<
                                                                TableController>()
                                                            .getRecordByFieldType(
                                                                "address1",
                                                                Get.arguments[
                                                                    'records'])
                                                            .userId,
                                                        Get.find<
                                                                TableController>()
                                                            .getRecordByFieldType(
                                                                "address1",
                                                                Get.arguments[
                                                                    'records'])
                                                            .type,
                                                        Get.find<
                                                                TableController>()
                                                            .getRecordByFieldType(
                                                                "address1",
                                                                Get.arguments[
                                                                    'records'])
                                                            .data,
                                                        value.toString());

                                                // Change the data of the record based on the given field type
                                                Get.find<TableController>()
                                                    .getRecordByFieldType(
                                                        "address1",
                                                        Get.arguments[
                                                            'records'])
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
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  initialValue: Get.find<
                                                          TableController>()
                                                      .getRecordByFieldType(
                                                          "city",
                                                          Get.arguments[
                                                              'records'])
                                                      .data,
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
                                                    if (Get.find<
                                                                TableController>()
                                                            .getRecordByFieldType(
                                                                "city",
                                                                Get.arguments[
                                                                    'records'])
                                                            .data !=
                                                        value.toString()) {
                                                      // Adds an RecordUpdate in the the list of updates
                                                      // RecordUpdate class allows us to track the changes we did in the user's information
                                                      Get.find<RecordUpdateController>().createRecordUpdate(
                                                          Get.find<
                                                                  TableController>()
                                                              .getRecordByFieldType(
                                                                  "city",
                                                                  Get.arguments[
                                                                      'records'])
                                                              .userId,
                                                          Get.find<
                                                                  TableController>()
                                                              .getRecordByFieldType(
                                                                  "city",
                                                                  Get.arguments[
                                                                      'records'])
                                                              .type,
                                                          Get.find<
                                                                  TableController>()
                                                              .getRecordByFieldType(
                                                                  "city",
                                                                  Get.arguments[
                                                                      'records'])
                                                              .data,
                                                          value.toString());

                                                      // Change the data of the record based on the given field type
                                                      Get.find<
                                                              TableController>()
                                                          .getRecordByFieldType(
                                                              "city",
                                                              Get.arguments[
                                                                  'records'])
                                                          .data = value.toString();

                                                      // Add the updated record to the list of updated records
                                                      Get.find<
                                                              RecordController>()
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
                                                  initialValue: Get.find<
                                                          TableController>()
                                                      .getRecordByFieldType(
                                                          "province",
                                                          Get.arguments[
                                                              'records'])
                                                      .data,
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
                                                    if (Get.find<
                                                                TableController>()
                                                            .getRecordByFieldType(
                                                                "province",
                                                                Get.arguments[
                                                                    'records'])
                                                            .data !=
                                                        value.toString()) {
                                                      // Adds an RecordUpdate in the the list of updates
                                                      // RecordUpdate class allows us to track the changes we did in the user's information
                                                      Get.find<RecordUpdateController>().createRecordUpdate(
                                                          Get.find<
                                                                  TableController>()
                                                              .getRecordByFieldType(
                                                                  "province",
                                                                  Get.arguments[
                                                                      'records'])
                                                              .userId,
                                                          Get.find<
                                                                  TableController>()
                                                              .getRecordByFieldType(
                                                                  "province",
                                                                  Get.arguments[
                                                                      'records'])
                                                              .type,
                                                          Get.find<
                                                                  TableController>()
                                                              .getRecordByFieldType(
                                                                  "province",
                                                                  Get.arguments[
                                                                      'records'])
                                                              .data,
                                                          value.toString());

                                                      // Change the data of the record based on the given field type
                                                      Get.find<
                                                              TableController>()
                                                          .getRecordByFieldType(
                                                              "province",
                                                              Get.arguments[
                                                                  'records'])
                                                          .data = value.toString();

                                                      // Add the updated record to the list of updated records
                                                      Get.find<
                                                              RecordController>()
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
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: 895,
                                            child: TextFormField(
                                              initialValue: Get.find<
                                                      TableController>()
                                                  .getRecordByFieldType(
                                                      "postal",
                                                      Get.arguments['records'])
                                                  .data,
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
                                                if (Get.find<TableController>()
                                                        .getRecordByFieldType(
                                                            "postal",
                                                            Get.arguments[
                                                                'records'])
                                                        .data !=
                                                    value.toString()) {
                                                  // Adds an RecordUpdate in the the list of updates
                                                  // RecordUpdate class allows us to track the changes we did in the user's information
                                                  Get.find<RecordUpdateController>().createRecordUpdate(
                                                      Get.find<
                                                              TableController>()
                                                          .getRecordByFieldType(
                                                              "postal",
                                                              Get.arguments[
                                                                  'records'])
                                                          .userId,
                                                      Get.find<
                                                              TableController>()
                                                          .getRecordByFieldType(
                                                              "postal",
                                                              Get.arguments[
                                                                  'records'])
                                                          .type,
                                                      Get.find<
                                                              TableController>()
                                                          .getRecordByFieldType(
                                                              "postal",
                                                              Get.arguments[
                                                                  'records'])
                                                          .data,
                                                      value.toString());

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
                        // Cancel and save button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Get.offAllNamed("/LeadDetails", arguments: {
                                  'records': Get.arguments['records'],
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white),
                              child: Text("Cancel", style: kButtonText2),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                if (Get.find<RecordController>()
                                    .validateTextField(
                                        Get.find<RecordController>()
                                            .updateFormKey)) {
                                  // Update all the records
                                  Get.find<RecordController>().updateRecord();

                                  // Insert all the updates in the database to keep track of all the changes
                                  Get.find<RecordUpdateController>()
                                      .insertAllUdpates();

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

import 'dart:async';
import 'package:crm/Widgets/Text_Field.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Models/record.dart';
import 'package:crm/Controllers/record_controller.dart';

class Panel extends StatelessWidget {
  late List<Record> recordsToInsert = [];
  // Key of the form. Used for validation if the user enters the required fields
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Keys of each fields
  final _firstNameTextFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _lastNameTextFormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _addressTextFormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _address2TextFormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _cityTextFormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _provinceTextFormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _postalTextFormKey =
      GlobalKey<FormFieldState>();

  // FocusNodes of each fields
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();
  final FocusNode _address2FocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _provinceFocusNode = FocusNode();
  final FocusNode _postalFocusNode = FocusNode();

  Widget _addressTextFormField(List<Record> recordsToInsert) {
    return TextFormField(
      key: _addressTextFormKey,
      focusNode: _addressFocusNode,
      decoration: InputDecoration(
        labelText: "Street Address *",
        labelStyle: GoogleFonts.rubik(fontSize: 20),
        hintText: "1130 rue Sherbrooke Ouest, Suite 700",
        hintStyle: GoogleFonts.rubik(fontSize: 20),
        errorStyle: GoogleFonts.rubik(fontSize: 20),
      ),
      maxLength: 60,
      validator: (String? value) {
        if (value.toString().isEmpty) {
          return "This field is required";
        }
      },
      onSaved: (value) {
        // Record newRecord = Record(1, 1, 'address', value.toString());
        // recordsToInsert.add(newRecord);
      },
    );
  }

  Widget _address2TextFormField(List<Record> recordsToInsert) {
    return TextFormField(
      key: _address2TextFormKey,
      focusNode: _address2FocusNode,
      decoration: InputDecoration(
        labelText: "Street Address Line 2",
        labelStyle: GoogleFonts.rubik(fontSize: 20),
        hintText: "1130 rue Sherbrooke Ouest, Suite 700",
        hintStyle: GoogleFonts.rubik(fontSize: 20),
        errorStyle: GoogleFonts.rubik(fontSize: 20),
      ),
      maxLength: 60,
      validator: (String? value) {
        if (value.toString().isEmpty) {
          return "This field is required";
        }
      },
      onSaved: (value) {
        // Record newRecord = Record(1, 1, 'address2', value.toString());
        // recordsToInsert.add(newRecord);
      },
    );
  }

  Widget _cityTextFormField(List<Record> recordsToInsert) {
    return TextFormField(
      key: _cityTextFormKey,
      focusNode: _cityFocusNode,
      decoration: InputDecoration(
        labelText: "City *",
        labelStyle: GoogleFonts.rubik(fontSize: 20),
        hintText: "Montreal",
        hintStyle: GoogleFonts.rubik(fontSize: 20),
        errorStyle: GoogleFonts.rubik(fontSize: 20),
      ),
      maxLength: 40,
      validator: (String? value) {
        if (value.toString().isEmpty) {
          return "This field is required";
        }
      },
      onSaved: (value) {
        // Record newRecord = Record(1, 1, 'city', value.toString());
        // recordsToInsert.add(newRecord);
      },
    );
  }

  Widget _provinceTextFormField(List<Record> recordsToInsert) {
    return TextFormField(
      key: _provinceTextFormKey,
      focusNode: _provinceFocusNode,
      decoration: InputDecoration(
        labelText: "State/Province *",
        labelStyle: GoogleFonts.rubik(fontSize: 20),
        hintText: "Quebec",
        hintStyle: GoogleFonts.rubik(fontSize: 20),
        errorStyle: GoogleFonts.rubik(fontSize: 20),
      ),
      maxLength: 40,
      validator: (String? value) {
        if (value.toString().isEmpty) {
          return "This field is required";
        }
      },
      onSaved: (value) {
        // Record newRecord = Record(1, 1, 'province', value.toString());
        // recordsToInsert.add(newRecord);
      },
    );
  }

  Widget _postalTextFormField(List<Record> recordsToInsert) {
    return TextFormField(
      key: _postalTextFormKey,
      focusNode: _postalFocusNode,
      decoration: InputDecoration(
        labelText: "Postal/ Zip Code *",
        labelStyle: GoogleFonts.rubik(fontSize: 20),
        hintText: "H3A 2M8",
        hintStyle: GoogleFonts.rubik(fontSize: 20),
        errorStyle: GoogleFonts.rubik(fontSize: 20),
      ),
      maxLength: 6,
      validator: (String? value) {
        if (value.toString().isEmpty) {
          return "This field is required";
        }
      },
      onSaved: (value) {
        // Record newRecord = Record(1, 1, 'postalcode', value.toString());
        // recordsToInsert.add(newRecord);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecordController());
    late List<Record> recordsToInsert = [];

    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 56, 91, 133),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Fields for the name of the user
                Container(
                  height: 180,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Full Name",
                        style: GoogleFonts.rubik(fontSize: 30),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextField(
                            labelText: "First Name *",
                            hintText: "Vincent",
                            fieldType: "firstName",
                            fieldId: 1,
                            maxLength: 40,
                            records: recordsToInsert,
                            controller: controller.firstNameController,
                          )),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                              child: CustomTextField(
                            labelText: "Last Name *",
                            hintText: "Benesen",
                            fieldType: "lastName",
                            fieldId: 2,
                            maxLength: 40,
                            records: recordsToInsert,
                            controller: controller.lastNameController,
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // Fields for the address of the user
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 440,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Address",
                        style: GoogleFonts.rubik(fontSize: 30),
                      ),
                      CustomTextField(
                        labelText: "Street Address *",
                        hintText: "1130 rue Sherbrooke Ouest, Suite 700",
                        fieldType: "address1",
                        fieldId: 3,
                        maxLength: 40,
                        records: recordsToInsert,
                        controller: controller.address1Controller,
                      ),
                      CustomTextField(
                        labelText: "Street Address Line 2",
                        hintText: "1130 rue Sherbrooke Ouest, Suite 700",
                        fieldType: "address2",
                        fieldId: 4,
                        maxLength: 40,
                        records: recordsToInsert,
                        controller: controller.address2Controller,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              labelText: "City *",
                              hintText: "Montreal",
                              fieldType: "city",
                              fieldId: 5,
                              maxLength: 40,
                              records: recordsToInsert,
                              controller: controller.cityController,
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: CustomTextField(
                              labelText: "Province *",
                              hintText: "Quebec",
                              fieldType: "Province",
                              fieldId: 6,
                              maxLength: 40,
                              records: recordsToInsert,
                              controller: controller.provinceController,
                            ),
                          ),
                        ],
                      ),
                      CustomTextField(
                        labelText: "Postal/Zip Code *",
                        hintText: "H3A 2M8",
                        fieldType: "postal",
                        fieldId: 7,
                        maxLength: 40,
                        records: recordsToInsert,
                        controller: controller.postalCodeController,
                      ),
                    ],
                  ),
                ),
                RaisedButton(onPressed: () {
                  controller.addRecords(recordsToInsert);
                  controller.getHighestUserId();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

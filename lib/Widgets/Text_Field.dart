import 'package:crm/Controllers/record_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../Models/record.dart';

class CustomTextField extends StatelessWidget {
  // final GlobalKey<FormFieldState> fieldkey;
  // final FocusNode focusNode;
  final String labelText;
  final String hintText;
  final String fieldType;
  final int fieldId;
  final int maxLength;
  final List<Record> records;
  final TextEditingController controller;
  // final int highestUserId;

  const CustomTextField({
    Key? key,
    // required this.fieldkey,
    // required this.focusNode,
    required this.labelText,
    required this.hintText,
    required this.fieldType,
    required this.fieldId,
    required this.maxLength,
    required this.records,
    required this.controller,
    // required this.highestUserId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // key: fieldkey,
      // focusNode: focusNode,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.rubik(fontSize: 20),
        hintText: hintText,
        hintStyle: GoogleFonts.rubik(fontSize: 20),
        errorStyle: GoogleFonts.rubik(fontSize: 20),
      ),
      maxLength: maxLength,
      controller: controller,
      validator: (String? value) {
        switch (fieldType) {
          case "address2":
            return null;
          default:
            if (value.toString().isEmpty) {
              return "This field is required";
            }
        }
      },
      onSaved: (value) {
        Record newRecord = Record(3, fieldId, fieldType, value.toString());
        records.add(newRecord);
      },
    );
  }
}

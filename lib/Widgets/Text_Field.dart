import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          case "phoneNumber":
          case "mobileNumber":
            if (value.toString().isEmpty) {
              return "This field is required";
            }

            // Check if the phone number is valid or not
            // Matches:
            //  +1 (555) 555-5555
            //  +1 555-555-5555
            //  +1 555 555 5555
            //  +1 555 555 5555 x1234
            //  555-555-5555
            //  555 555 5555
            //  5555555555
            //  5555555555 x1234
            //  1 555 555 5555
            if (!RegExp(
                    r"^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$")
                .hasMatch(value.toString())) {
              return "Please enter a valid phone number";
            }
            break;
          case "email":
            // Check if the email is empty
            if (value.toString().isEmpty) {
              return "This field is required";
            }
            // Check if the email is valid or not
            if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value.toString())) {
              return "Please enter a valid email";
            }
            break;
          case "other":
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

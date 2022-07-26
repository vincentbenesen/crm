import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crm/models/record.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Panel extends StatefulWidget {
  const Panel({Key? key}) : super(key: key);

  @override
  State<Panel> createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  late List<Record> recordsToInsert = [];

  // Key of the form. Used for validation if the user enters the required fields
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Keys of each fields
  final GlobalKey<FormFieldState> _firstNameTextFormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _lastNameTextFormKey =
      GlobalKey<FormFieldState>();

  // FocusNodes of each fields
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();

  //Get all the records from the database
  Stream<List<Record>> getAllElements() {
    return (FirebaseFirestore.instance.collection("records").snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Record.fromMap(doc.data())).toList()));
  }

  // insert to Firebase
  void insertRecord(Record record) {
    final docRecord = FirebaseFirestore.instance.collection('records').doc();
    // FirebaseFirestore.instance.collection('users').add(profile.toMap());
    docRecord.set(record.toMap());
  }

  // adds the element inside the database
  void addElements(List<Record> records) {
    records.forEach((record) {
      insertRecord(record);
    });
  }

  // First Name
  Widget _firstnameTextFormField(
      int? dataLength, List<Record> records, List<Record> recordsToInsert) {
    return TextFormField(
      key: _firstNameTextFormKey,
      focusNode: _firstNameFocusNode,
      decoration: InputDecoration(
        labelText: "First Name",
        labelStyle: GoogleFonts.rubik(fontSize: 20),
        hintText: "Vincent",
        hintStyle: GoogleFonts.rubik(fontSize: 15),
        errorStyle: GoogleFonts.rubik(fontSize: 15),
      ),
      maxLength: 40,
      validator: (String? value) {},
      onSaved: (value) {
        Record newRecord = Record(
            (dataLength! == 0 ? 1 : records[dataLength - 1].userId + 1),
            1,
            'firstName',
            value.toString());
        recordsToInsert.add(newRecord);
      },
    );
  }

  // Last Name
  Widget _lastnameTextFormField(
      int? dataLength, List<Record> records, List<Record> recordsToInsert) {
    return TextFormField(
      key: _lastNameTextFormKey,
      focusNode: _lastNameFocusNode,
      decoration: InputDecoration(
        labelText: "Last Name",
        labelStyle: GoogleFonts.rubik(fontSize: 20),
        hintText: "Benesen",
        hintStyle: GoogleFonts.rubik(fontSize: 15),
        errorStyle: GoogleFonts.rubik(fontSize: 15),
      ),
      maxLength: 40,
      validator: (String? value) {},
      onSaved: (value) {
        Record newRecord = Record(
            (dataLength! == 0 ? 1 : records[dataLength - 1].userId + 1),
            1,
            'lastName',
            value.toString());
        recordsToInsert.add(newRecord);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Record>>(
        stream: getAllElements(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int? dataLength = snapshot.data?.length;
            List<Record> records = snapshot.data!;
            return Form(
              key: _formKey,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 56, 91, 133),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 200,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Full Name (Required)",
                              style: GoogleFonts.rubik(fontSize: 25),
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: _firstnameTextFormField(
                                        dataLength, records, recordsToInsert)),
                                const SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                    child: _lastnameTextFormField(
                                        dataLength, records, recordsToInsert))
                              ],
                            ),
                            RaisedButton(onPressed: () {
                              _formKey.currentState?.save();
                              addElements(recordsToInsert);
                              // Clear the list of records so that we only insert the new records
                              recordsToInsert.clear();
                            })
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

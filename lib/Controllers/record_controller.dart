import 'package:crm/Widgets/Text_Field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Models/record.dart';

class RecordController extends GetxController {
  // To access the records from the database.
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;

  // These are the variables used to manipulate the data in the textfields.
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController,
      lastNameController,
      address1Controller,
      address2Controller,
      cityController,
      provinceController,
      postalCodeController,
      phoneNumberController,
      mobileNumberController,
      emailController;

  // This record list is for displaying the records (fetch all the records and insert to this list).
  final recordList = <Record>[].obs;

  // This record is for adding the records in the firebase.
  final recordsToInsert = <Record>[].obs;

  RxString typeField = "".obs;
  RxInt numberOfNewFields = 1.obs;

  @override
  void onInit() {
    super.onInit();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    address1Controller = TextEditingController();
    address2Controller = TextEditingController();
    cityController = TextEditingController();
    provinceController = TextEditingController();
    postalCodeController = TextEditingController();
    phoneNumberController = TextEditingController();
    mobileNumberController = TextEditingController();
    emailController = TextEditingController();

    collectionReference = firestore.collection('records');
  }

  // This function is used to fetch all the records from the database.
  Future<void> fetchRecords() async {
    QuerySnapshot records = await collectionReference.orderBy('userId').get();

    records.docs.forEach((record) {
      recordList.add(Record(
          record['userId'], record['fieldId'], record['type'], record['data']));
    });
  }

  // Adds the records in Firestore
  void addRecords(List<Record> records) async {
    int highestId = await getHighestUserId();
    highestId++;
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();

      // Removes the records with empty data from the list. This is to avoid adding empty records to the firebase.
      // This is specifically for address2 field.
      records.removeWhere((thisRecord) => thisRecord.data.isEmpty);

      for (var record in records) {
        collectionReference.add(record.toMap(highestId));
      }
      records.clear();
      formKey.currentState?.reset();
    }
  }

  void incrementNumberOfNewFields() {
    numberOfNewFields.value++;
  }

  // Returns the highest userId from Firestore
  Future<int> getHighestUserId() async {
    try {
      Future<QuerySnapshot<Object?>> record = collectionReference
          .orderBy('userId', descending: true)
          .limit(1)
          .get();
      return await record.then((QuerySnapshot querySnapshot) {
        return (querySnapshot.docs.first['userId']);
      });
    } catch (e) {
      return Future<int>.value(0);
    }
  }

  // This function opens an alert dialog to ask the user for the type of new field that will be added.
  Future addNewCustomField(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Type Of Information",
            style: GoogleFonts.rubik(fontSize: 20),
          ),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Please Enter The Type Of Field',
              hintStyle: GoogleFonts.rubik(fontSize: 20),
            ),
            onChanged: (value) {
              typeField.value = value;
            },
          ),
          actions: [
            FlatButton(
              child: Text(
                'Cancel',
                style: GoogleFonts.rubik(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                'Add',
                style: GoogleFonts.rubik(fontSize: 20),
              ),
              onPressed: () {
                incrementNumberOfNewFields();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

  Widget newField(String fieldType) {
    return CustomTextField(
        labelText: fieldType,
        hintText: 'Enter',
        fieldType: fieldType,
        fieldId: 0,
        maxLength: 40,
        records: recordsToInsert,
        controller: TextEditingController());
  }

  ListView customRecords(String fieldType, int count) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: count,
      itemBuilder: (context, index) {
        return newField(fieldType);
      },
    );
  }
}

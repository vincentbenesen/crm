import 'package:crm/Widgets/text_Field.dart';
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
  final GlobalKey<FormState> nameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> contactFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> otherInfoFormKey = GlobalKey<FormState>();

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
  // final recordsToInsert = <Record>[].obs;
  final Map<String, Record> recordToInsert = <String, Record>{}.obs;

  // These variables are used for fields that are added by the user.
  final fieldName = ''.obs;
  final fieldtypes = <String?>[].obs;
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

    fieldtypes.add('Other');
  }

  // Increment the number of new fields by 1. It starts from 0.
  void incrementNumberOfNewFields() {
    numberOfNewFields.value++;
  }

  // Decrement the number of new fields by 1.
  void decrementtNumberOfNewFields() {
    numberOfNewFields.value--;
  }

  // This function is used to fetch all the records from the database.
  Future<void> fetchRecords() async {
    QuerySnapshot records = await collectionReference.orderBy('userId').get();

    records.docs.forEach((record) {
      recordList.add(Record(
          record['userId'], record['fieldId'], record['type'], record['data']));
    });
  }

  bool validateTextField(GlobalKey<FormState> key) {
    if (key.currentState!.validate()) {
      key.currentState?.save();
      return true;
    }
    return false;
  }

  // Adds the records in Firestore
  void addRecords(Map<String, Record> records) async {
    int highestId = await getHighestUserId();
    highestId++;

    // Removes the records with empty data from the list. This is to avoid adding empty records to the firebase.
    records.removeWhere((key, value) => value.data.isEmpty);

    // Inserts the records in the firebase.
    records.forEach((key, value) {
      collectionReference.add(value.toMap(highestId));
    });

    // Clears all the records from the map after inserting it in firebase .
    records.clear();
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
      // If there are no records in the database, then the userId is 0.
      return Future<int>.value(0);
    }
  }

  // This function opens an alert dialog to ask the user for the type of new field that will be added.
  Future addNewCustomField(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Type of information",
            style: GoogleFonts.rubik(fontSize: 20),
          ),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Please enter the type of field',
              hintStyle: GoogleFonts.rubik(fontSize: 20),
            ),
            onChanged: (value) {
              fieldName.value = value;
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
                fieldtypes.add(fieldName.value);

                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

  // This function is used to add the new field to the list of fields.
  Widget newField(int index, String? fieldType, BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 1400,
          child: CustomTextField(
            labelText: fieldType.toString(),
            hintText: 'Enter the information',
            fieldType: (fieldType?.camelCase).toString(),
            fieldId: 0,
            maxLength: 40,
            records: recordToInsert,
            controller: TextEditingController(),
          ),
        ),
        // Add button
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: index == fieldtypes.length - 1 ? true : false,
              child: SizedBox(
                width: 20,
                child: IconButton(
                  icon: const Icon(
                    Icons.add_circle,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    addNewCustomField(context);
                  },
                ),
              ),
            ),
            const SizedBox(width: 20),
            Visibility(
              visible:
                  (index == fieldtypes.length - 1 && index >= 1) ? true : false,
              child: SizedBox(
                width: 20,
                child: IconButton(
                  icon: const Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    fieldtypes.removeAt(index);
                    decrementtNumberOfNewFields();
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel_dart/excel_dart.dart';
import 'package:email_validator/email_validator.dart';
import 'package:async/async.dart';

import '../Models/record.dart';
import 'package:crm/Widgets/text_Field.dart';
import 'package:crm/constant.dart';

class RecordController extends GetxController {
  // To access the records from the database.
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference recordReference;
  late CollectionReference progressReference;

  // These are the variables used to manipulate the data in the textfields.
  GlobalKey<FormState> nameFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> contactFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> otherInfoFormKey = GlobalKey<FormState>();

  // This variable is used for the form that updates the record in the the edit lead page.
  GlobalKey<FormState> updateFormKey = GlobalKey<FormState>();

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

  // This record is for updating the records in the firebase.
  final recordsToUpdate = <Record>[].obs;

  // These variables are used for fields that are added by the user.
  final fieldName = ''.obs;
  final fieldtypes = <String?>[].obs;
  RxInt numberOfNewFields = 1.obs;

  // We need this variable to update the userId for the new record in Firebase
  RxInt highestUserId = 0.obs;

  // Checks if the excel file is successfully imported to Firebase
  RxBool isImported = false.obs;

  // This variable is managing the rating of a lead
  RxDouble rating = 0.0.obs;

  @override
  void onInit() async {
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

    recordReference = firestore.collection('records');
    progressReference = firestore.collection('progress');

    fieldtypes.add('Other');

    highestUserId.value = await getHighestUserId();
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
  Future<List<Record>> fetchRecords() async {
    QuerySnapshot records = await recordReference.get();

    records.docs.forEach((record) {
      recordList.add(Record(record['userId'], record['fieldId'], record['type'],
          record['data'], record['documentId']));
    });

    return recordList;
  }

  // This record is used to retrieve the records from the database based on the given userId. This is used to display the records in the table.
  Future<List<Record>> getRecordsById(int userId) async {
    QuerySnapshot records =
        await recordReference.where('userId', isEqualTo: userId).get();

    records.docs.forEach((record) {
      recordList.add(Record(
          record['userId'], record['fieldId'], record['type'], record['data']));
    });

    return recordList;
  }

  // This function is used to retrieve the records from the database based on the given fieldType.
  Future<Record> getRecordByFieldType(
      String fieldType, Future<List<Record>> records) async {
    return await records.then((records) {
      return records.firstWhere((record) => record.type == fieldType);
    });
  }

  Future<List<Record>> getRecordByName() async {
    QuerySnapshot records =
        await recordReference.where('data', isEqualTo: 'Lisa').get();

    records.docs.forEach((record) {
      recordList.add(Record(record['userId'], record['fieldId'], record['type'],
          record['data'], record['documentId']));
    });

    print(recordList);

    return recordList;
  }

  // Get both collections (records and logs) from Firebase and it returns a querysnapshot
  Stream<List<QuerySnapshot>> getRecordsAndLogs() {
    Stream<QuerySnapshot<Object?>> recordsSnapshot =
        recordReference.snapshots();
    Stream<QuerySnapshot<Object?>> progressSnapshot =
        progressReference.snapshots();
    return StreamZip([recordsSnapshot, progressSnapshot]);
  }

  // This function is used to update the records from the database based on the given docId.
  void updateRecord() {
    recordsToUpdate.forEach((element) {
      recordReference.doc(element.documentId).update({
        'userId': element.userId,
        'fieldId': element.fieldId,
        'type': element.type,
        'data': element.data,
      });
    });

    recordsToUpdate.clear();
  }

  // This function is used to delete the records from the database based on the given docId.
  void deleteRecord(List<Record> records) {
    records.forEach((record) {
      recordReference.doc(record.documentId).delete();
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
    Record initialRating = Record(highestId, 13, 'ratings', '0');

    // This is to add a record for ratings. As a default a lead will start with 0 rating
    records.addEntries([MapEntry('ratings', initialRating)]);

    // Removes the records with empty data from the list. This is to avoid adding empty records to the firebase.
    records.removeWhere((key, value) => value.data.isEmpty);

    // Inserts the records in the firebase.
    records.forEach((key, value) {
      value.documentId = recordReference.doc().id;
      recordReference.doc(value.documentId).set(value.toMap(highestId));
    });

    // Clears all the records from the map after inserting it in firebase .
    records.clear();
  }

  // Returns the highest userId from Firestore
  Future<int> getHighestUserId() async {
    try {
      Future<QuerySnapshot<Object?>> record =
          recordReference.orderBy('userId', descending: true).limit(1).get();
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
            ElevatedButton(
              child: Text(
                'Cancel',
                style: GoogleFonts.rubik(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
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

  // Checks if the data is null or not
  String isStringDataNull(String data) {
    if (data == 'null') {
      return 'N/A';
    }
    return data;
  }

  // Check if the string is empty or not
  String? isStringEmpty(String? data) {
    if (data.toString().trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  // Check if the email is valid or not
  String? isEmailValid(String? email) {
    if (!EmailValidator.validate(email.toString()) &&
        email.toString().isNotEmpty) {
      return 'Please enter a valid email';
    }
    return isStringEmpty(email.toString());
  }

  // This method is used to validate the phone number of the user
  String? isPhoneNumberValid(String? number) {
    if (number.toString().isNotEmpty) {
      if (!RegExp(kPhoneRegex).hasMatch(number.toString())) {
        return "Please enter a valid phone number";
      }
      return null;
    }

    return 'This field is required';
  }

  // Imports the data from an Excel file to firebase
  // This method only accept files with an extensiont of 'xls', 'xlsx', 'csv'.
  void importFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['xls', 'xlsx', 'csv']);
    int maxRow = 0;
    int maxColumn = 0;
    final recordsMap = <int, List<String>>{};

    if (result != null) {
      var bytes = result.files.single.bytes;
      var excel = Excel.decodeBytes(bytes!);
      for (var table in excel.tables.keys) {
        maxColumn = excel.tables[table]!.maxCols;
        maxRow = excel.tables[table]!.maxRows;
        for (var i = 1; i < maxRow; i++) {
          for (var j = 0; j < maxColumn + 1; j++) {
            try {
              if (recordsMap.containsKey(i)) {
                recordsMap[i]!
                    .add(excel.tables[table]!.rows[i][j]!.value.toString());
              } else {
                recordsMap.addEntries([
                  MapEntry(
                      i, [excel.tables[table]!.rows[i][j]!.value.toString()])
                ]);
              }
            } catch (Exception) {
              if (recordsMap.containsKey(i)) {
                if (j == maxColumn) {
                  // This is the default rating for the customer which is 0
                  recordsMap[i]!.add('0');
                } else {
                  recordsMap[i]!.add("null");
                }
              } else {
                recordsMap.addEntries([
                  MapEntry(i, ["null"])
                ]);
              }
            }
          }
        }
      }
    }

    // After reading the data and inserting all the records in a map
    // we insert those data using this method
    insertRecordsFromExcel(recordsMap, maxColumn);
  }

  // Get the type of data based on the position of the column
  // This method is used when we read the data from excel file
  String getTypeOfData(int column) {
    switch (column) {
      case 0:
        return 'firstName';
      case 1:
        return 'lastName';
      case 2:
        return 'address1';
      case 3:
        return 'city';
      case 4:
        return 'province';
      case 5:
        return 'postal';
      case 6:
        return 'email';
      case 7:
        return 'mobileNumber';
      case 8:
        return 'phoneNumber';
      case 9:
        return 'busTelephone';
      case 10:
        return 'howFoundUs';
      case 11:
        return 'type';
      case 12:
        return 'comments';
      case 13:
        return 'ratings';
      default:
        return '';
    }
  }

  // Get the field id based on the position of the column
  // This method is used when we read the data from excel file
  int getFieldId(int column) {
    switch (column) {
      case 0:
        return 1;
      case 1:
        return 2;
      case 2:
        return 3;
      case 3:
        return 5;
      case 4:
        return 6;
      case 5:
        return 7;
      case 6:
        return 9;
      case 7:
        return 8;
      case 8:
        return 8;
      case 9:
        return 8;
      case 10:
        return 10;
      case 11:
        return 11;
      case 12:
        return 12;
      case 13:
        return 13;
      default:
        return 0;
    }
  }

  // This method allows us to insert all the records to Firebase
  void insertRecordsFromExcel(
      Map<int, List<String>> records, int maxColumn) async {
    int highestUserId = await getHighestUserId();
    String documentId = '';
    for (var record in records.values) {
      highestUserId++;
      for (var i = 0; i < maxColumn + 1; i++) {
        documentId = recordReference.doc().id;
        recordReference.doc(documentId).set(Record(highestUserId, getFieldId(i),
                getTypeOfData(i), record[i], documentId)
            .toMap(highestUserId));
      }
    }

    isImported.value = true;
    Get.offAllNamed('/Leads');
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../Models/record.dart';

class TableController extends GetxController {
  final leadsColumns =
      ["Name", "Address", "Telephone Number", "Mobile Number", "Email"].obs;

  final recordList = <Record>[].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;

  @override
  onInit() {
    super.onInit();
    collectionReference = firestore.collection('records');
  }

  void populateList(List<Record> records) {
    recordList.value = records;
  }

  // This record is used to retrieve the records from the database based on the given userId. This is used to display the records in the table.
  List<Record> getRecordsById(List<Record> records, int userId) {
    return records.where((record) => record.userId == userId).toList();
  }

  // This function is used to retrieve the records from the database based on the given fieldType.
  Record getRecordByFieldType(String fieldType, List<Record> records) {
    return records.firstWhere((record) => record.type == fieldType);
  }

  // This function is used to get all the columns for the table
  List<DataColumn> getColumns(List<String> columns) {
    return columns
        .map((column) =>
            DataColumn(label: SizedBox(width: 350, child: Text(column))))
        .toList();
  }

  // This function is used to get all the cells that will be inserted in a row for the table
  List<DataCell> getCells(List<dynamic> cells) {
    return cells.map((data) => DataCell(Text(data.toString()))).toList();
  }

  // This function is used to get all the rows for the table
  List<DataRow> getRows(List<Record> records) {
    return records
        // I need to get the records based on the name. That means if there 3 names then we will have 3 rows in the table.
        // If I based it on the record itself then I will have multiple rows in the table since some records has the same userId.
        .where((record) => record.type == "firstName")
        .map((row) => DataRow(
                cells: getCells([
              // Since I have the length of the list I can get the index of the record. I can now get the data based on their userId and fieldType
              getRecordByFieldType(
                      'firstName', getRecordsById(records, row.userId))
                  .data,
              getRecordByFieldType(
                'address1',
                getRecordsById(records, row.userId),
              ).data,
              getRecordByFieldType(
                      'phoneNumber', getRecordsById(records, row.userId))
                  .data,
              getRecordByFieldType(
                      'mobileNumber', getRecordsById(records, row.userId))
                  .data,
              getRecordByFieldType('email', getRecordsById(records, row.userId))
                  .data
            ])))
        .toList();
  }

  Widget dataTable(
    List<DataColumn> columns,
    List<Record> records,
  ) {
    return DataTable(columns: getColumns(leadsColumns), rows: getRows(records));
  }
}

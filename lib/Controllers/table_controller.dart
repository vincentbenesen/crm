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

  // These variables are used for sorting the records.
  RxInt index = 0.obs;
  RxBool isAscending = false.obs;

  // These variables are used to show the information of the user in the EditLead page.
  RxBool showContactInfo = true.obs;
  RxBool showPhoneandEmail = true.obs;
  RxBool showAddressInfo = true.obs;

  @override
  onInit() {
    super.onInit();
    collectionReference = firestore.collection('records');
  }

  void setToTrue(RxBool bool) {
    bool.value = true;
  }

  void setToFalse(RxBool bool) {
    bool.value = false;
  }

  // This record is used to retrieve the records from the database based on the given userId. This is used to display the records in the table.
  List<Record> getRecordsById(List<Record> records, int userId) {
    return records.where((record) => record.userId == userId).toList();
  }

  // This function is used to retrieve the records from the database based on the given fieldType.
  Record getRecordByFieldType(String fieldType, List<Record> records) {
    return records.firstWhere((record) => record.type == fieldType);
  }

  // This function is used to retrieve the id of the record from the database based on the given fieldType and Data.
  int getUserIdByFieldTypeAndData(
      String fieldType, String data, List<Record> records) {
    return records
        .firstWhere((record) => record.type == fieldType && record.data == data)
        .userId;
  }

  // This function is used to get all the columns for the table
  List<DataColumn> getColumns(List<String> columns, List<Record> records) {
    return columns
        .map((column) => DataColumn(
            onSort: ((columnIndex, ascending) {
              onSort(columnIndex, columnIndex > 0 ? false : ascending, records);
            }),
            label: SizedBox(width: 315, child: Text(column))))
        .toList();
  }

  // This function is used to get all the cells that will be inserted in a row for the table
  List<DataCell> getCells(List<dynamic> cells, List<Record> records) {
    return cells
        .map((data) => DataCell(InkWell(
            onTap: () {
              if (!data.toString().contains(new RegExp(r'[0-9-\@]'))) {
                // print(data.toString().split(" ").first);

                Get.offAllNamed('/LeadDetails', arguments: {
                  'records': getRecordsById(
                      records,
                      getUserIdByFieldTypeAndData("firstName",
                          data.toString().split(" ").first, records)),
                });
              }
            },
            child: Text(data.toString()))))
        .toList();
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
              "${getRecordByFieldType('firstName', getRecordsById(records, row.userId)).data} ${getRecordByFieldType('lastName', getRecordsById(records, row.userId)).data}",
              "${getRecordByFieldType(
                'address1',
                getRecordsById(records, row.userId),
              ).data} ${getRecordByFieldType('city', getRecordsById(records, row.userId)).data}, ${getRecordByFieldType('province', getRecordsById(records, row.userId)).data}, ${getRecordByFieldType('postal', getRecordsById(records, row.userId)).data}",
              getRecordByFieldType(
                      'phoneNumber', getRecordsById(records, row.userId))
                  .data,
              getRecordByFieldType(
                      'mobileNumber', getRecordsById(records, row.userId))
                  .data,
              getRecordByFieldType('email', getRecordsById(records, row.userId))
                  .data
            ], records)))
        .toList();
  }

  // Returns the table with the given columns and rows. It is used to display the records.
  // Widget dataTable(
  //   List<DataColumn> columns,
  //   List<Record> records,
  // ) {
  //   return Obx(
  //     () => DataTable(
  //       columns: getColumns(leadsColumns),
  //       rows: getRows(records),
  //     ),
  //   );
  // }

  int compareString(String a, String b, bool ascending) {
    return ascending ? a.compareTo(b) : b.compareTo(a);
  }

  void onSort(int columnIndex, bool ascending, List<Record> records) {
    switch (columnIndex) {
      case 0:
        // records.sort((a, b) => compareString(a.data, b.data, ascending));
        records
            // .where((record) => record.type == "firstName")
            // .toList()
            .sort((a, b) => compareString(a.data, b.data, ascending));
        break;
      // case 1:
      // records.sort((a, b) => compareString(
      //     (a.type == "address1" ? a.data : continueWithAddress(a.data)),
      //     (b.type == "address1" ? b.data : ""),
      //     ascending));
      // break;
      // case 2:
      //   records.sort((a, b) => a.data.compareTo(b.data));
      //   break;
      // case 3:
      //   records.sort((a, b) => a.data.compareTo(b.data));
      //   break;
      // case 4:
      //   records.sort((a, b) => a.data.compareTo(b.data));
      //   break;
    }
    index.value = columnIndex;
    isAscending.value = ascending;
  }
}

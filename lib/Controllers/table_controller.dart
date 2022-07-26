import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crm/Controllers/log_controller.dart';
import 'package:crm/Controllers/progress_controller.dart';
import 'package:crm/Models/progressData.dart';
import 'package:crm/constant.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../Models/record.dart';

class TableController extends GetxController {
  final leadsColumns = ["Name", "Address", "Telephone", "Mobile", "Email"].obs;

  final recordList = <Record>[].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;

  // These variables are used for sorting the records.
  String typeToSort = 'firstName';
  RxInt index = 0.obs;
  RxBool isAscending = false.obs;

  // These variables are used to show the information of the user in the EditLead page.
  RxBool showContactInfo = true.obs;
  RxBool showPhoneandEmail = true.obs;
  RxBool showAddressInfo = true.obs;

  // final mapss = (Map<int, List<Record>>).obs;
  // RxInt numOfMatches = 0.obs;
  // RxString name = ''.obs;
  final searchController = TextEditingController();

  var progressController = Get.find<ProgressController>();

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

  // Checks if there are matches name from all the the leads. Get all the matching names and store it in a list
  List<Record> matchesName(List<Record> records, String name) {
    return records
        .where((record) =>
            (record.data.toLowerCase().startsWith(name.trim().toLowerCase()) &&
                (record.type == 'firstName' || record.type == 'lastName')) &&
            name.isNotEmpty)
        .toList();
  }

  // Get all the information of the matching names
  List<Record> result(List<Record> records, List<Record> names) {
    List<Record> results = <Record>[];
    for (var names in names) {
      for (var record in records) {
        if (names.userId == record.userId) {
          results.add(record);
        }
      }
    }

    return results;
  }

  // This record is used to retrieve the records from the database based on the given userId. This is used to display the records in the table.
  // This is used specifically in the ListView in the leads.dart file
  List<Record> getRecordsByIndex(List<Record> records, int index) {
    index++;
    return records.where((record) => record.userId == index).toList();
  }

  // This record is used to retrieve the records from the database based on the given userId. This is used to display the records in the table.
  List<Record> getRecordsById(List<Record> records, int userId) {
    return records.where((record) => record.userId == userId).toList();
  }

  // This record is used to retrieve the records from the database based on the given userId. This is used to display the records in the table.
  List<Record> getRecordsByName(List<Record> records, String name) {
    return records.where((record) => record.data == name).toList();
  }

  // This function is used to retrieve the records from the database based on the given fieldType.
  Record getRecordByFieldType(String fieldType, List<Record> records) {
    try {
      Record record = records.firstWhere((record) => record.type == fieldType);
      return record;
    } catch (E) {
      return Record(0, 0, "N/A", "N/A");
    }
  }

  // This function is used to retrieve the id of the record from the database based on the given fieldType and Data.
  int getUserIdByFieldTypeAndData(
      String fieldType, String data, List<Record> records) {
    return records
        .firstWhere((record) => record.type == fieldType && record.data == data)
        .userId;
  }

  // This function is used to get all the columns for the table
  List<DataColumn> getColumns(
      List<String> columns, List<Record> records, BuildContext context) {
    return columns
        .map((column) => DataColumn(
            onSort: ((columnIndex, ascending) {
              onSort(columnIndex, ascending, records);
            }),
            label: Flexible(child: Text(column))))
        .toList();
  }

  // This function is used to get all the cells that will be inserted in a row for the table
  List<DataCell> getCells(List<dynamic> cells, List<Record> records,
      List<ProgressData> progressDataList) {
    return cells
        .map((data) => DataCell(InkWell(
            onTap: () {
              if (!data.toString().contains(new RegExp(r'[0-9-\@]'))) {
                // Get all the records of the lead based on their last name
                // Then send this data to LeadDetails page
                Get.offAllNamed('/LeadDetails', arguments: {
                  'records': getRecordsById(
                      records,
                      getUserIdByFieldTypeAndData("lastName",
                          data.toString().split(" ").last, records)),
                  'progressDataList':
                      progressController.getListProgressDataById(
                          progressDataList,
                          getUserIdByFieldTypeAndData("lastName",
                              data.toString().split(" ").last, records))
                });

                Get.find<LogController>().userId.value =
                    getUserIdByFieldTypeAndData(
                        "lastName", data.toString().split(" ").last, records);
              }
            },
            child: Text(data.toString()))))
        .toList();
  }

  List<DataRow> getRows(
      List<Record> records, List<ProgressData> progressDataList) {
    return records
        // I need to get the records based on the name. That means if there 3 names then we will have 3 rows in the table.
        // If I based it on the record itself then I will have multiple rows in the table since some records has the same userId.
        .where((record) => record.type == typeToSort)
        .map((row) => DataRow(
                cells: getCells([
              // Since I have the length of the list I can get the index of the record. I can now get the data based on their userId and fieldType
              "${getRecordByFieldType('firstName', getRecordsById(records, row.userId)).data} ${getRecordByFieldType('lastName', getRecordsById(records, row.userId)).data}",
              "${getRecordByFieldType(
                'address1',
                getRecordsById(records, row.userId),
              ).data} ${getRecordByFieldType('city', getRecordsById(records, row.userId)).data}, ${getRecordByFieldType('province', getRecordsById(records, row.userId)).data}, ${getRecordByFieldType('postal', getRecordsById(records, row.userId)).data}",
              getRecordByFieldType('phoneNumber',
                              getRecordsById(records, row.userId))
                          .data ==
                      'null'
                  ? 'N/A'
                  : getRecordByFieldType(
                          'phoneNumber', getRecordsById(records, row.userId))
                      .data,
              getRecordByFieldType('mobileNumber',
                              getRecordsById(records, row.userId))
                          .data ==
                      'null'
                  ? 'N/A'
                  : getRecordByFieldType(
                          'mobileNumber', getRecordsById(records, row.userId))
                      .data,
              getRecordByFieldType('email', getRecordsById(records, row.userId))
                          .data ==
                      'null'
                  ? 'N/A'
                  : getRecordByFieldType(
                          'email', getRecordsById(records, row.userId))
                      .data
            ], records, progressDataList)))
        .toList();
  }

  int compareString(String a, String b, bool ascending, String typeToSort) {
    this.typeToSort = typeToSort;
    return ascending ? a.compareTo(b) : b.compareTo(a);
  }

  Map<int, List<Record>> convertListToMap(List<Record> records) {
    Map<int, List<Record>> recordsMap = <int, List<Record>>{};

    for (Record record in records) {
      if (recordsMap.containsKey(record.userId)) {
        recordsMap[record.userId]!.add(record);
      } else {
        recordsMap.addEntries([
          MapEntry(record.userId, [record])
        ]);
      }
    }

    return recordsMap;
  }

  void onSort(int columnIndex, bool ascending, List<Record> records) {
    switch (columnIndex) {
      // This case is for the firstName
      case kIndex0:
        records.sort(
            (a, b) => compareString(a.data, b.data, ascending, kFirstName));
        break;
      // This case is for the address.
      case kIndex1:
        records.sort(
            (a, b) => compareString(a.data, b.data, ascending, kAddress1));
        break;
      // This case is for the telephone number
      case kIndex2:
        records.sort(
            (a, b) => compareString(a.data, b.data, ascending, kPhoneNumber));
        break;
      // This case is for the mobile number
      case kIndex3:
        records.sort(
            (a, b) => compareString(a.data, b.data, ascending, kMobileNumber));
        break;
      // This case is for the email
      case kIndex4:
        records
            .sort((a, b) => compareString(a.data, b.data, ascending, kEmail));
        break;
    }
    index.value = columnIndex;
    isAscending.value = ascending;
  }
}

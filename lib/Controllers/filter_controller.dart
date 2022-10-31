import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crm/Models/mail.dart';
import 'package:crm/constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Models/record.dart';

class FilterController extends GetxController {
  RxBool isForRatings = true.obs;
  RxBool isFilterPressed = false.obs;
  RxBool isCityOptionOpen = false.obs;
  RxBool isTypeOfUnitOpen = false.obs;
  RxBool isRatingOptionOPen = false.obs;

  final citiesToSearch = <String>[].obs;
  final unitsToSearch = <String>[].obs;
  final ratingsToSearch = <double>[].obs;

  void isFilterButtonClicked() {
    if (!isFilterPressed.value) {
      isFilterPressed.value = true;
    } else {
      isFilterPressed.value = false;
    }
  }

  void isCityButtonClicked() {
    if (!isCityOptionOpen.value) {
      isCityOptionOpen.value = true;
    } else {
      isCityOptionOpen.value = false;
    }
  }

  void isTypeOfUnitButtonClicked() {
    if (!isTypeOfUnitOpen.value) {
      isTypeOfUnitOpen.value = true;
    } else {
      isTypeOfUnitOpen.value = false;
    }
  }

  void isRatingButtonClicked() {
    if (!isRatingOptionOPen.value) {
      isRatingOptionOPen.value = true;
    } else {
      isRatingOptionOPen.value = false;
    }
  }

  // Checks if a record matches all the cities that are filtered by the user
  bool isRecordContainsState(Record record) {
    if (citiesToSearch.isEmpty) {
      return true;
    }
    for (String city in citiesToSearch) {
      if (record.data == city) {
        return true;
      }
    }
    return false;
  }

  // Checks if a record matches all the unit that are filtered by the user
  bool isRecordContainsUnit(Record record) {
    if (unitsToSearch.isEmpty) {
      return true;
    }
    for (String unit in unitsToSearch) {
      if (record.data.contains(unit)) {
        return true;
      }
    }
    return false;
  }

  // Checks if a lead has this rating
  bool isRecordContainsRating(Record record) {
    if (ratingsToSearch.isEmpty) {
      return true;
    }
    for (double rating in ratingsToSearch) {
      if (record.data == rating.toString()) {
        return true;
      }
    }
    return false;
  }

  List<Record> filterRecords(Map<int, List<Record>> recordsMap) {
    List<Record> filteredRecords = [];

    recordsMap.forEach((key, records) {
      for (Record record in records) {
        if (isRecordContainsState(record) &&
            isRecordContainsUnit(record) &&
            isRecordContainsRating(record)) {
          filteredRecords.addAll(records);
        }
      }
    });

    return filteredRecords;
  }
}

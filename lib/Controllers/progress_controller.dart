import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crm/Models/progressData.dart';
import 'package:crm/constant.dart';
import 'package:get/get.dart';

class ProgressController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference progressReference;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    progressReference = firestore.collection('progress');
  }

  void insertProgressRecords(List<ProgressData> progressList) {
    progressList.forEach((progressData) {
      progressData.documentId = progressReference.doc().id;
      progressReference.doc(progressData.documentId).set(progressData.toMap());
    });
  }

  List<ProgressData> generateListOfProgressData(
      List<String> listOfProgressTitle, int userId) {
    List<ProgressData> progressDataList = [];
    listOfProgressTitle.forEach((title) {
      progressDataList.add(ProgressData(userId, title, 'N/A', 'N/A'));
    });

    return progressDataList;
  }

  // Get the list of progress data from
  List<ProgressData> getProgressData(QuerySnapshot<Object?> snapshot) {
    List<ProgressData> progressDataList = [];

    snapshot.docs.forEach((progressData) {
      Timestamp? estimateDate;
      Timestamp? finishDate;
      try {
        estimateDate = progressData[kEstimateDate];
        finishDate = progressData[kFinishDate];
        progressDataList.add(ProgressData(
            progressData[kUserId],
            progressData[kTitle],
            DateTime.fromMillisecondsSinceEpoch(
                    estimateDate!.millisecondsSinceEpoch)
                .toString(),
            DateTime.fromMillisecondsSinceEpoch(
                    finishDate!.millisecondsSinceEpoch)
                .toString()));
      } catch (e) {
        progressDataList.add(ProgressData(
            progressData[kUserId],
            progressData[kTitle],
            progressData[kEstimateDate] == 'N/A'
                ? 'N/A'
                : DateTime.fromMillisecondsSinceEpoch(
                        estimateDate!.millisecondsSinceEpoch)
                    .toString(),
            progressData[kFinishDate] == 'N/A'
                ? 'N/A'
                : DateTime.fromMillisecondsSinceEpoch(
                        finishDate!.millisecondsSinceEpoch)
                    .toString()));
      }
    });
    return progressDataList;
  }

  // Convert the list of progress data to a map
  Map<int, List<ProgressData>> convertListToMapPData(
      List<ProgressData> listPData, userId) {
    Map<int, List<ProgressData>> pDataMap = <int, List<ProgressData>>{};

    for (ProgressData pData in listPData) {
      if (pDataMap.containsKey(pData.userId)) {
        pDataMap[pData.userId]!.add(pData);
      } else {
        pDataMap.addEntries([
          MapEntry(pData.userId, [pData])
        ]);
      }
    }

    return pDataMap;
  }
}

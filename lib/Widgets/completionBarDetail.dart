import 'package:crm/Controllers/progress_controller.dart';
import 'package:crm/Controllers/record_controller.dart';
import 'package:crm/Controllers/table_controller.dart';
import 'package:crm/Models/progressData.dart';
import 'package:crm/Models/record.dart';
import 'package:crm/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:progress_stepper/progress_stepper.dart';

class CompletionBarDetail extends StatelessWidget {
  CompletionBarDetail({
    super.key,
    required this.recordsList,
    required this.progressDataList,
  });

  var progressController = Get.find<ProgressController>();
  var tableController = Get.find<TableController>();
  final List<Record> recordsList;
  final List<ProgressData> progressDataList;
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: ProgressStepper(
        width: 200,
        // The total number of progress level
        stepCount: 9,
        builder: (index) {
          double widthOfStep = 200;
          progressController.progressRecord.value =
              tableController.getRecordByFieldType('progress', recordsList);
          // Checks if the progress data is N/A
          // Usually progress is N/A as default. If it is then N/A, we replace it 0
          progressController.progressLevel.value =
              progressController.progressRecord.value.data == 'null'
                  ? 0
                  : int.parse(tableController
                      .getRecordByFieldType('progress', recordsList)
                      .data);
          for (var i = 0; i < index; i++) {
            // progressController.currentColor.value = progressController.getColor(
            //     progressController.getProgressData(
            //         kProgressList[index - 1], progressDataList));
            // This if statement in here because the first arrow has a different design from the rest of the arrows
            if (index == 1) {
              return Tooltip(
                decoration: BoxDecoration(color: kColorPearlWhite),
                richMessage: TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text:
                          'Estimate date: ${progressController.formatDate(progressController.getProgressData(kProgressList[index - 1], progressDataList)!.estimateDate)}\n',
                      style: kUserText,
                    ),
                    TextSpan(
                      text:
                          'Finish date: ${progressController.getProgressData(kProgressList[index - 1], progressDataList)!.finishDate} ',
                      style: kUserText,
                    ),
                  ],
                ),
                child: Obx(
                  // FocusedMenuHolder is a libray that allows to have a pop up buttons when the widget is clicked
                  // FocuseMenuItem are the buttons that appears when the widget is clicked
                  () => ProgressStepWithArrow(
                    width: widthOfStep,
                    defaultColor: progressController.getColor(
                        progressController.getProgressData(
                            kProgressList[index - 1], progressDataList)),
                    progressColor: kColorLighterBlue,
                    wasCompleted:
                        progressController.progressLevel.value >= index
                            ? true
                            : false,
                    child: Center(
                        // Checks if the progress is mark as done
                        // If tehe progress is done, the title will be replace by a check mark icon
                        child: progressController.progressLevel.value >= index
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                              )
                            : Text(
                                kProgressList[index - 1],
                                style: kProgressText,
                              )),
                  ),
                ),
              );
            }

            // FocusedMenuHolder is a libray that allows to have a pop up buttons when the widget is clicked
            // FocuseMenuItem are the buttons that appears when the widget is clicked
            return Tooltip(
              decoration: BoxDecoration(color: kColorPearlWhite),
              richMessage: TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text:
                        'Estimate date: ${progressController.formatDate(progressController.getProgressData(kProgressList[index - 1], progressDataList)!.estimateDate)}\n',
                    style: kUserText,
                  ),
                  TextSpan(
                    text:
                        'Finish date: ${progressController.getProgressData(kProgressList[index - 1], progressDataList)!.finishDate} ',
                    style: kUserText,
                  ),
                ],
              ),
              child: Obx(
                () => ProgressStepWithChevron(
                  width: widthOfStep,
                  defaultColor: progressController.getColor(
                      progressController.getProgressData(
                          kProgressList[index - 1], progressDataList)),
                  progressColor: kColorLighterBlue,
                  wasCompleted: progressController.progressLevel.value >= index
                      ? true
                      : false,
                  child: Center(
                    child: progressController.progressLevel.value >= index
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                        : progressController.progressLevel.value == index - 1
                            ? Text(
                                kProgressList[index - 1],
                                style: kProgressText,
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    kProgressList[index - 1],
                                    style: kProgressText,
                                  ),
                                  const Icon(
                                    Icons.lock,
                                    size: 20,
                                    color: kColorPearlWhite,
                                  )
                                ],
                              ),
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

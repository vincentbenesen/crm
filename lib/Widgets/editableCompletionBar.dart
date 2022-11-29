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

import 'package:progress_stepper/progress_stepper.dart';

class EditableCompletionBar extends StatelessWidget {
  EditableCompletionBar({
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
              return Obx(
                // FocusedMenuHolder is a libray that allows to have a pop up buttons when the widget is clicked
                // FocuseMenuItem are the buttons that appears when the widget is clicked
                () => FocusedMenuHolder(
                  onPressed: () {},
                  menuWidth: 200,
                  openWithTap: true,
                  menuItems:
                      // Checks if the customer alread finished the current progress
                      // If its already finish the options would not appear anymore
                      progressController.progressLevel.value >= index
                          ? []
                          : [
                              FocusedMenuItem(
                                  title: Text("Mark as done"),
                                  trailingIcon: Icon(Icons.check),
                                  onPressed: () {
                                    progressController.progressLevel.value =
                                        index;
                                    progressController
                                            .progressRecord.value.data =
                                        progressController.progressLevel.value
                                            .toString();
                                    progressController.updateProgress(
                                        progressController
                                            .progressRecord.value);
                                  }),
                              FocusedMenuItem(
                                  title: Text("Set estimate date"),
                                  trailingIcon: Icon(Icons.calendar_month),
                                  onPressed: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: today,
                                        firstDate: today,
                                        lastDate: DateTime(2030));
                                    // update the estimate time of a progress
                                    progressController.updateProgressRecord(
                                        progressController.getProgressData(
                                            kProgressList[index - 1],
                                            progressDataList),
                                        pickedDate);

                                    Get.offAllNamed(kToLead);
                                  }),
                            ],
                  // This is the first progress bar
                  child: ProgressStepWithArrow(
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
            return Obx(
              () => FocusedMenuHolder(
                onPressed: () {},
                menuWidth: 200,
                openWithTap: true,
                // Checks if the customer alread finished the current progress
                // If its already finish the options would not appear anymore
                menuItems: progressController.progressLevel.value >= index
                    ? []
                    : [
                        FocusedMenuItem(
                            title: Text("Mark as done"),
                            trailingIcon: Icon(Icons.check),
                            onPressed: () {
                              // When the mark as done button is clicked, update the current progress level
                              progressController.progressLevel.value = index;
                              progressController.progressRecord.value.data =
                                  progressController.progressLevel.value
                                      .toString();
                              progressController.updateProgress(
                                  progressController.progressRecord.value);
                            }),
                        FocusedMenuItem(
                            title: Text("Set estimate date"),
                            trailingIcon: Icon(Icons.calendar_month),
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: today,
                                  firstDate: today,
                                  lastDate: DateTime(2030));
                              // update the estimate time of a progress
                              progressController.updateProgressRecord(
                                  progressController.getProgressData(
                                      kProgressList[index - 1],
                                      progressDataList),
                                  pickedDate);

                              Get.offAllNamed(kToLead);
                            }),
                      ],
                // This is the rest of the progress bar
                child: ProgressStepWithChevron(
                  width: widthOfStep,
                  defaultColor:
                      // progressController.progressLevel.value == index - 1
                      //     ? progressController.currentColor.value
                      //     : kColorDarkBlue,
                      progressController.getColor(
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

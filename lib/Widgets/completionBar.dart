import 'package:crm/Controllers/progress_controller.dart';
import 'package:crm/Controllers/record_controller.dart';
import 'package:crm/Controllers/table_controller.dart';
import 'package:crm/Models/record.dart';
import 'package:crm/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';

import 'package:progress_stepper/progress_stepper.dart';

class CompletionBar extends StatelessWidget {
  CompletionBar({super.key, required this.recordsList});
  var progressController = Get.find<ProgressController>();
  var tableController = Get.find<TableController>();

  final List<Record> recordsList;

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
        stepCount: 9,
        builder: (index) {
          double widthOfStep = 200;
          progressController.progressRecord.value =
              tableController.getRecordByFieldType('progress', recordsList);
          progressController.progressLevel.value =
              progressController.progressRecord.value.data == 'null'
                  ? 0
                  : int.parse(tableController
                      .getRecordByFieldType('progress', recordsList)
                      .data);
          for (var i = 0; i < index; i++) {
            if (index == 1) {
              return Obx(
                () => FocusedMenuHolder(
                  onPressed: () {},
                  menuWidth: 200,
                  openWithTap: true,
                  menuItems: <FocusedMenuItem>[
                    FocusedMenuItem(
                        title: Text("Mark as done"),
                        trailingIcon: Icon(Icons.check),
                        onPressed: () {
                          progressController.progressLevel.value = index;
                          progressController.progressRecord.value.data =
                              progressController.progressLevel.value.toString();
                          progressController.updateProgress(
                              progressController.progressRecord.value);
                        }),
                    FocusedMenuItem(
                        title: Text("Set estimate date"),
                        trailingIcon: Icon(Icons.calendar_month),
                        onPressed: () {}),
                  ],
                  child: ProgressStepWithArrow(
                    width: widthOfStep,
                    defaultColor: kColorDarkBlue,
                    progressColor: kColorLighterBlue,
                    wasCompleted:
                        progressController.progressLevel.value >= index
                            ? true
                            : false,
                    child: Center(
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

            return Obx(
              () => FocusedMenuHolder(
                onPressed: () {},
                menuWidth: 200,
                openWithTap: true,
                menuItems: <FocusedMenuItem>[
                  FocusedMenuItem(
                      title: Text("Mark as done"),
                      trailingIcon: Icon(Icons.check),
                      onPressed: () {
                        progressController.progressLevel.value = index;
                        progressController.progressRecord.value.data =
                            progressController.progressLevel.value.toString();
                        progressController.updateProgress(
                            progressController.progressRecord.value);
                      }),
                  FocusedMenuItem(
                      title: Text("Set estimate date"),
                      trailingIcon: Icon(Icons.calendar_month),
                      onPressed: () {}),
                ],
                child: ProgressStepWithChevron(
                  width: widthOfStep,
                  defaultColor: kColorDarkBlue,
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
                                )),
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

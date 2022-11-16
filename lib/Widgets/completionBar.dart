import 'package:crm/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

import 'package:progress_stepper/progress_stepper.dart';

class CompletionBar extends StatelessWidget {
  CompletionBar({super.key});

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
          int isSelected = 0;
          for (var i = 0; i < index; i++) {
            if (index == 1) {
              return FocusedMenuHolder(
                onPressed: () {},
                menuWidth: 200,
                child: ProgressStepWithArrow(
                  width: widthOfStep,
                  defaultColor: kColorDarkBlue,
                  progressColor: kColorLighterBlue,
                  wasCompleted: isSelected >= index ? true : false,
                  child: Center(
                      child: isSelected >= index
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                            )
                          : Text(
                              kProgressList[index - 1],
                              style: kProgressText,
                            )),
                ),
                openWithTap: true,
                menuItems: <FocusedMenuItem>[
                  FocusedMenuItem(
                      title: Text("Share"),
                      trailingIcon: Icon(Icons.share),
                      onPressed: () {
                        print(isSelected);
                        isSelected = index;
                        print(isSelected);
                      }),
                  FocusedMenuItem(
                      title: Text("Favorite"),
                      trailingIcon: Icon(Icons.favorite_border),
                      onPressed: () {}),
                  FocusedMenuItem(
                      title: Text(
                        "Delete",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                      trailingIcon: Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {}),
                ],
              );
            }

            return FocusedMenuHolder(
              onPressed: () {},
              menuWidth: 200,
              child: ProgressStepWithChevron(
                width: widthOfStep,
                defaultColor: kColorDarkBlue,
                progressColor: kColorLighterBlue,
                wasCompleted: isSelected >= index ? true : false,
                child: Center(
                    child: isSelected >= index
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                        : Text(
                            kProgressList[index - 1],
                            style: kProgressText,
                          )),
              ),
              openWithTap: true,
              menuItems: <FocusedMenuItem>[
                FocusedMenuItem(
                    title: Text("Mark as done"),
                    trailingIcon: Icon(Icons.share),
                    onPressed: () {
                      print(isSelected);
                      isSelected = index;
                      print(isSelected);
                    }),
                FocusedMenuItem(
                    title: Text("Favorite"),
                    trailingIcon: Icon(Icons.favorite_border),
                    onPressed: () {}),
                FocusedMenuItem(
                    title: Text(
                      "Delete",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    trailingIcon: Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                    onPressed: () {}),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

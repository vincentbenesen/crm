import 'dart:async';
import 'package:crm/Controllers/stepper_controller.dart';
import 'package:crm/Widgets/navbar.dart';
import 'package:crm/Widgets/text_Field.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:crm/Controllers/record_controller.dart';

class Panel extends StatelessWidget {
  const Panel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: Get.find<RecordController>().formKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 56, 91, 133),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Fields for the name of the user
              Expanded(
                child: Obx(
                  () => Stepper(
                    type: StepperType.horizontal,
                    currentStep:
                        Get.find<StepperController>().currentStep.value,
                    onStepTapped: (value) {},
                    onStepCancel: () {
                      Get.find<StepperController>().decrement();
                    },
                    onStepContinue: () {
                      Get.find<RecordController>().validateTextField();
                      Get.find<StepperController>().increment();
                    },
                    steps: Get.find<StepperController>().getSteps(
                      Container(
                        height: 180,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Full Name",
                              style: GoogleFonts.rubik(fontSize: 30),
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: CustomTextField(
                                  labelText: "First Name *",
                                  hintText: "Vincent",
                                  fieldType: "firstName",
                                  fieldId: 1,
                                  maxLength: 40,
                                  records: Get.find<RecordController>()
                                      .recordsToInsert,
                                  controller: Get.find<RecordController>()
                                      .firstNameController,
                                )),
                                const SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                    child: CustomTextField(
                                  labelText: "Last Name *",
                                  hintText: "Benesen",
                                  fieldType: "lastName",
                                  fieldId: 2,
                                  maxLength: 40,
                                  records: Get.find<RecordController>()
                                      .recordsToInsert,
                                  controller: Get.find<RecordController>()
                                      .lastNameController,
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 440,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Address",
                              style: GoogleFonts.rubik(fontSize: 30),
                            ),
                            CustomTextField(
                              labelText: "Street Address *",
                              hintText: "1130 rue Sherbrooke Ouest, Suite 700",
                              fieldType: "address1",
                              fieldId: 3,
                              maxLength: 40,
                              records:
                                  Get.find<RecordController>().recordsToInsert,
                              controller: Get.find<RecordController>()
                                  .address1Controller,
                            ),
                            CustomTextField(
                              labelText: "Street Address Line 2",
                              hintText: "1130 rue Sherbrooke Ouest, Suite 700",
                              fieldType: "address2",
                              fieldId: 4,
                              maxLength: 40,
                              records:
                                  Get.find<RecordController>().recordsToInsert,
                              controller: Get.find<RecordController>()
                                  .address2Controller,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    labelText: "City *",
                                    hintText: "Montreal",
                                    fieldType: "city",
                                    fieldId: 5,
                                    maxLength: 40,
                                    records: Get.find<RecordController>()
                                        .recordsToInsert,
                                    controller: Get.find<RecordController>()
                                        .cityController,
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: CustomTextField(
                                    labelText: "Province *",
                                    hintText: "Quebec",
                                    fieldType: "Province",
                                    fieldId: 6,
                                    maxLength: 40,
                                    records: Get.find<RecordController>()
                                        .recordsToInsert,
                                    controller: Get.find<RecordController>()
                                        .provinceController,
                                  ),
                                ),
                              ],
                            ),
                            CustomTextField(
                              labelText: "Postal/Zip Code *",
                              hintText: "H3A 2M8",
                              fieldType: "postal",
                              fieldId: 7,
                              maxLength: 40,
                              records:
                                  Get.find<RecordController>().recordsToInsert,
                              controller: Get.find<RecordController>()
                                  .postalCodeController,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

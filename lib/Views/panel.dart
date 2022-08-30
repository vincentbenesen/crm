import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:crm/Controllers/stepper_controller.dart';
import 'package:crm/Widgets/navbar.dart';
import 'package:crm/Widgets/text_Field.dart';
import 'package:crm/constant.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:crm/Controllers/record_controller.dart';

class Panel extends StatelessWidget {
  const Panel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        // padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 56, 91, 133),
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Navbar(),
              const SizedBox(height: 10),
              // Fields for the name of the user
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Obx(
                    () => Theme(
                      data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                              primary: Color.fromARGB(255, 56, 91, 133))),
                      child: Stepper(
                        type: StepperType.horizontal,
                        currentStep:
                            Get.find<StepperController>().currentStep.value,
                        onStepTapped: (value) {},
                        onStepCancel: () {
                          if (Get.find<StepperController>().currentStep.value ==
                              0) {
                            Get.offAllNamed("/Leads");
                          } else if (Get.find<StepperController>()
                                  .currentStep
                                  .value ==
                              1) {
                            Get.find<RecordController>()
                                .recordToInsert
                                .remove("firstName");

                            Get.find<RecordController>()
                                .recordToInsert
                                .remove("lastName");
                          } else if (Get.find<StepperController>()
                                  .currentStep
                                  .value ==
                              2) {
                            Get.find<RecordController>()
                                .recordToInsert
                                .remove("address1");

                            Get.find<RecordController>()
                                .recordToInsert
                                .remove("address2");

                            Get.find<RecordController>()
                                .recordToInsert
                                .remove("city");

                            Get.find<RecordController>()
                                .recordToInsert
                                .remove("province");

                            Get.find<RecordController>()
                                .recordToInsert
                                .remove("postal");
                          } else if (Get.find<StepperController>()
                                  .currentStep
                                  .value ==
                              3) {
                            Get.find<RecordController>()
                                .recordToInsert
                                .remove("phoneNumber");
                            Get.find<RecordController>()
                                .recordToInsert
                                .remove("mobileNumber");
                            Get.find<RecordController>()
                                .recordToInsert
                                .remove("email");
                          }

                          Get.find<StepperController>().decrement();
                        },
                        onStepContinue: () {
                          switch (
                              Get.find<StepperController>().currentStep.value) {
                            case 0:
                              if (Get.find<RecordController>()
                                  .validateTextField(
                                      Get.find<RecordController>()
                                          .nameFormKey)) {
                                Get.find<StepperController>().increment();
                              }
                              break;
                            case 1:
                              if (Get.find<RecordController>()
                                  .validateTextField(
                                      Get.find<RecordController>()
                                          .addressFormKey)) {
                                Get.find<StepperController>().increment();
                              }
                              break;
                            case 2:
                              if (Get.find<RecordController>()
                                  .validateTextField(
                                      Get.find<RecordController>()
                                          .contactFormKey)) {
                                Get.find<StepperController>().increment();
                              }
                              break;
                            case 3:
                              if (Get.find<RecordController>()
                                  .validateTextField(
                                      Get.find<RecordController>()
                                          .otherInfoFormKey)) {
                                Get.find<RecordController>().addRecords(
                                    Get.find<RecordController>()
                                        .recordToInsert);

                                AwesomeDialog(
                                  context: context,
                                  width: 370,
                                  animType: AnimType.SCALE,
                                  headerAnimationLoop: false,
                                  dialogType: DialogType.SUCCES,
                                  title: 'Record Inserted',
                                  btnOkOnPress: () {
                                    // Go back to Lead page
                                    Get.offAllNamed("/Leads");
                                  },
                                  btnOkIcon: Icons.check_circle,
                                  onDissmissCallback: (type) {},
                                ).show();
                              }
                              break;
                          }
                        },
                        controlsBuilder: (context, controls) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FlatButton(
                                  onPressed: controls.onStepCancel,
                                  color: kColorDarkBlue,
                                  height: 50,
                                  minWidth: 130,
                                  child: Text("Cancel", style: kButtonText3),
                                ),
                                const SizedBox(width: 20),
                                FlatButton(
                                  onPressed: controls.onStepContinue,
                                  color: kColorDarkBlue,
                                  height: 50,
                                  minWidth: 130,
                                  child: Text(
                                    "Continue",
                                    style: kButtonText3,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        steps: Get.find<StepperController>().getSteps(
                          // Name of the user
                          Form(
                            key: Get.find<RecordController>().nameFormKey,
                            child: Container(
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
                                    style: kPanelTextH1,
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
                                            .recordToInsert,
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
                                            .recordToInsert,
                                        controller: Get.find<RecordController>()
                                            .lastNameController,
                                      )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Address Information
                          Form(
                            key: Get.find<RecordController>().addressFormKey,
                            child: Container(
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
                                    style: kPanelTextH1,
                                  ),
                                  CustomTextField(
                                    labelText: "Street Address *",
                                    hintText:
                                        "1130 rue Sherbrooke Ouest, Suite 700",
                                    fieldType: "address1",
                                    fieldId: 3,
                                    maxLength: 40,
                                    records: Get.find<RecordController>()
                                        .recordToInsert,
                                    controller: Get.find<RecordController>()
                                        .address1Controller,
                                  ),
                                  CustomTextField(
                                    labelText: "Street Address Line 2",
                                    hintText:
                                        "1130 rue Sherbrooke Ouest, Suite 700",
                                    fieldType: "address2",
                                    fieldId: 4,
                                    maxLength: 40,
                                    records: Get.find<RecordController>()
                                        .recordToInsert,
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
                                              .recordToInsert,
                                          controller:
                                              Get.find<RecordController>()
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
                                          fieldType: "province",
                                          fieldId: 6,
                                          maxLength: 40,
                                          records: Get.find<RecordController>()
                                              .recordToInsert,
                                          controller:
                                              Get.find<RecordController>()
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
                                    records: Get.find<RecordController>()
                                        .recordToInsert,
                                    controller: Get.find<RecordController>()
                                        .postalCodeController,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Contact Information
                          Form(
                            key: Get.find<RecordController>().contactFormKey,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 70, vertical: 20),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Contact Information",
                                    style: kPanelTextH1,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          labelText: "Phone *",
                                          hintText: "123456789",
                                          fieldType: "phoneNumber",
                                          fieldId: 8,
                                          maxLength: 10,
                                          records: Get.find<RecordController>()
                                              .recordToInsert,
                                          controller:
                                              Get.find<RecordController>()
                                                  .phoneNumberController,
                                        ),
                                      ),
                                      const SizedBox(width: 30),
                                      Expanded(
                                        child: CustomTextField(
                                          labelText: "Email *",
                                          hintText: "123@yahoo.com",
                                          fieldType: "email",
                                          fieldId: 9,
                                          maxLength: 100,
                                          records: Get.find<RecordController>()
                                              .recordToInsert,
                                          controller:
                                              Get.find<RecordController>()
                                                  .emailController,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 850,
                                    child: CustomTextField(
                                      labelText: "Mobile *",
                                      hintText: "123456789",
                                      fieldType: "mobileNumber",
                                      fieldId: 8,
                                      maxLength: 10,
                                      records: Get.find<RecordController>()
                                          .recordToInsert,
                                      controller: Get.find<RecordController>()
                                          .mobileNumberController,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Additional Information
                          Form(
                            key: Get.find<RecordController>().otherInfoFormKey,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 70, vertical: 20),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Additional Information",
                                    style: kPanelTextH1,
                                  ),
                                  Obx(
                                    () => ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: Get.find<RecordController>()
                                          .numberOfNewFields
                                          .value,
                                      itemBuilder: (context, index) {
                                        return Get.find<RecordController>()
                                            .newField(
                                                index,
                                                Get.find<RecordController>()
                                                    .fieldtypes[index],
                                                context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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

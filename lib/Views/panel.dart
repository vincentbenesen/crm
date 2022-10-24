import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:crm/Widgets/custom_AppBar.dart';
import 'package:crm/constant.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:crm/Widgets/navbar.dart';
import 'package:crm/Widgets/text_Field.dart';
import 'package:crm/Controllers/record_controller.dart';
import 'package:crm/Controllers/stepper_controller.dart';

class Panel extends StatelessWidget {
  Panel({Key? key}) : super(key: key);

  // These variables are for controllers
  var recordController = Get.find<RecordController>();
  var stepperController = Get.find<StepperController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      drawer: Navbar(),
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
                        currentStep: stepperController.currentStep.value,
                        onStepTapped: (value) {},
                        onStepCancel: () {
                          if (stepperController.currentStep.value == 0) {
                            Get.offAllNamed(kToLead);
                          } else if (stepperController.currentStep.value == 1) {
                            // Removes the records from the list of records that will be inserted when
                            // we go back to the previous page
                            recordController.recordToInsert.remove(kFirstName);
                            recordController.recordToInsert.remove(kLastName);
                          } else if (stepperController.currentStep.value == 2) {
                            // Removes the records from the list of records that will be inserted when
                            // we go back to the previous page
                            recordController.recordToInsert.remove(kAddress1);
                            recordController.recordToInsert.remove(kAddress2);
                            recordController.recordToInsert.remove(kCity);
                            recordController.recordToInsert.remove(kProvince);
                            recordController.recordToInsert.remove(kPostal);
                          } else if (stepperController.currentStep.value == 3) {
                            // Removes the records from the list of records that will be inserted when
                            // we go back to the previous page
                            recordController.recordToInsert
                                .remove(kPhoneNumber);
                            recordController.recordToInsert
                                .remove(kMobileNumber);
                            recordController.recordToInsert.remove(kEmail);
                          }

                          stepperController.decrement();
                        },
                        onStepContinue: () {
                          switch (stepperController.currentStep.value) {
                            case 0:
                              if (recordController.validateTextField(
                                  recordController.nameFormKey)) {
                                stepperController.increment();
                              }
                              break;
                            case 1:
                              if (recordController.validateTextField(
                                  recordController.addressFormKey)) {
                                stepperController.increment();
                              }
                              break;
                            case 2:
                              if (recordController.validateTextField(
                                  recordController.contactFormKey)) {
                                stepperController.increment();
                              }
                              break;
                            case 3:
                              if (recordController.validateTextField(
                                  recordController.otherInfoFormKey)) {
                                recordController.addRecords(
                                    recordController.recordToInsert);

                                AwesomeDialog(
                                  context: context,
                                  width: 370,
                                  animType: AnimType.SCALE,
                                  headerAnimationLoop: false,
                                  dialogType: DialogType.SUCCES,
                                  title: 'Record Inserted',
                                  btnOkOnPress: () {
                                    // Go back to Lead page
                                    Get.offAllNamed(kToLead);
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
                                ElevatedButton(
                                  onPressed: controls.onStepCancel,
                                  child: Text("Cancel", style: kButtonText3),
                                ),
                                const SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: controls.onStepContinue,
                                  child: Text(
                                    "Continue",
                                    style: kButtonText3,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        steps: stepperController.getSteps(
                          // Name of the user
                          Form(
                            key: recordController.nameFormKey,
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
                                    kFullNameTitle,
                                    style: kPanelTextH1,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: CustomTextField(
                                        labelText: kFirstNameLabelText,
                                        hintText: kFirstNameHintText,
                                        fieldType: kFirstName,
                                        fieldId: 1,
                                        maxLength: 40,
                                        records:
                                            recordController.recordToInsert,
                                        controller: recordController
                                            .firstNameController,
                                      )),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Expanded(
                                          child: CustomTextField(
                                        labelText: kLastNameLabelText,
                                        hintText: kLastNameHintText,
                                        fieldType: kLastName,
                                        fieldId: 2,
                                        maxLength: 40,
                                        records:
                                            recordController.recordToInsert,
                                        controller:
                                            recordController.lastNameController,
                                      )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Address Information
                          Form(
                            key: recordController.addressFormKey,
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
                                    kAddressTitle,
                                    style: kPanelTextH1,
                                  ),
                                  CustomTextField(
                                    labelText: kAddress1LabelText,
                                    hintText: kAddressHintText,
                                    fieldType: kAddress1,
                                    fieldId: 3,
                                    maxLength: 40,
                                    records: recordController.recordToInsert,
                                    controller:
                                        recordController.address1Controller,
                                  ),
                                  CustomTextField(
                                    labelText: kAddress2LabelText,
                                    hintText: kAddressHintText,
                                    fieldType: kAddress2,
                                    fieldId: 4,
                                    maxLength: 40,
                                    records: recordController.recordToInsert,
                                    controller:
                                        recordController.address2Controller,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          labelText: kCityLabelText,
                                          hintText: kCityHintText,
                                          fieldType: kCity,
                                          fieldId: 5,
                                          maxLength: 40,
                                          records:
                                              recordController.recordToInsert,
                                          controller:
                                              recordController.cityController,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Expanded(
                                        child: CustomTextField(
                                          labelText: kProvinceLabelText,
                                          hintText: kProvinceHintText,
                                          fieldType: kProvince,
                                          fieldId: 6,
                                          maxLength: 40,
                                          records:
                                              recordController.recordToInsert,
                                          controller: recordController
                                              .provinceController,
                                        ),
                                      ),
                                    ],
                                  ),
                                  CustomTextField(
                                    labelText: kPostalLabelText,
                                    hintText: kPostalHintText,
                                    fieldType: kPostal,
                                    fieldId: 7,
                                    maxLength: 40,
                                    records: recordController.recordToInsert,
                                    controller:
                                        recordController.postalCodeController,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Contact Information
                          Form(
                            key: recordController.contactFormKey,
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
                                    kContactInfoTitle,
                                    style: kPanelTextH1,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          labelText: kPhoneLabelText,
                                          hintText: kPhoneNumberHintText,
                                          fieldType: kPhoneNumber,
                                          fieldId: 8,
                                          maxLength: 10,
                                          records:
                                              recordController.recordToInsert,
                                          controller: recordController
                                              .phoneNumberController,
                                        ),
                                      ),
                                      const SizedBox(width: 30),
                                      Expanded(
                                        child: CustomTextField(
                                          labelText: kEmailLabelText,
                                          hintText: kEmailHintText,
                                          fieldType: kEmail,
                                          fieldId: 9,
                                          maxLength: 100,
                                          records:
                                              recordController.recordToInsert,
                                          controller:
                                              recordController.emailController,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 850,
                                    child: CustomTextField(
                                      labelText: kMobileLabelText,
                                      hintText: kPhoneNumberHintText,
                                      fieldType: kMobileNumber,
                                      fieldId: 8,
                                      maxLength: 10,
                                      records: recordController.recordToInsert,
                                      controller: recordController
                                          .mobileNumberController,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Additional Information
                          Form(
                            key: recordController.otherInfoFormKey,
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
                                      itemCount: recordController
                                          .numberOfNewFields.value,
                                      itemBuilder: (context, index) {
                                        return recordController.newField(
                                            index,
                                            recordController.fieldtypes[index],
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

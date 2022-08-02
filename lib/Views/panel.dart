import 'dart:async';
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Navbar(),
                const SizedBox(height: 20),
                // Fields for the name of the user
                Container(
                  height: 180,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
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
                            records:
                                Get.find<RecordController>().recordsToInsert,
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
                            records:
                                Get.find<RecordController>().recordsToInsert,
                            controller:
                                Get.find<RecordController>().lastNameController,
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // Fields for the address of the user
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 440,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
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
                        records: Get.find<RecordController>().recordsToInsert,
                        controller:
                            Get.find<RecordController>().address1Controller,
                      ),
                      CustomTextField(
                        labelText: "Street Address Line 2",
                        hintText: "1130 rue Sherbrooke Ouest, Suite 700",
                        fieldType: "address2",
                        fieldId: 4,
                        maxLength: 40,
                        records: Get.find<RecordController>().recordsToInsert,
                        controller:
                            Get.find<RecordController>().address2Controller,
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
                              records:
                                  Get.find<RecordController>().recordsToInsert,
                              controller:
                                  Get.find<RecordController>().cityController,
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
                              records:
                                  Get.find<RecordController>().recordsToInsert,
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
                        records: Get.find<RecordController>().recordsToInsert,
                        controller:
                            Get.find<RecordController>().postalCodeController,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Contact Information",
                        style: GoogleFonts.rubik(fontSize: 30),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              labelText: "Phone",
                              hintText: "123456789",
                              fieldType: "phoneNumber",
                              fieldId: 8,
                              maxLength: 10,
                              records:
                                  Get.find<RecordController>().recordsToInsert,
                              controller: Get.find<RecordController>()
                                  .phoneNumberController,
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: CustomTextField(
                              labelText: "Email",
                              hintText: "123@yahoo.com",
                              fieldType: "email",
                              fieldId: 9,
                              maxLength: 100,
                              records:
                                  Get.find<RecordController>().recordsToInsert,
                              controller:
                                  Get.find<RecordController>().emailController,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 780,
                        child: CustomTextField(
                          labelText: "Mobile",
                          hintText: "123456789",
                          fieldType: "mobileNumner",
                          fieldId: 8,
                          maxLength: 10,
                          records: Get.find<RecordController>().recordsToInsert,
                          controller: Get.find<RecordController>()
                              .mobileNumberController,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Additional Information",
                        style: GoogleFonts.rubik(fontSize: 30),
                      ),
                      Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          itemCount: Get.find<RecordController>()
                              .numberOfNewFields
                              .value,
                          itemBuilder: (context, index) {
                            return Get.find<RecordController>().newField(
                                index,
                                Get.find<RecordController>().fieldtypes[index],
                                context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                RaisedButton(onPressed: () {
                  Get.find<RecordController>()
                      .addRecords(Get.find<RecordController>().recordsToInsert);
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

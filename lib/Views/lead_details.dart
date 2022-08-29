import 'package:crm/Widgets/navbar.dart';
import 'package:crm/constant.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../Controllers/log_controller.dart';
import '../Controllers/record_controller.dart';
import '../Controllers/table_controller.dart';

class LeadDetails extends StatelessWidget {
  // final List<Record> records;
  const LeadDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      backgroundColor: kColorDarkBlue,
      body: SingleChildScrollView(
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: [
              Navbar(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // This container is where all three buttons are (Edit, Delete, and Go Back) and Contact Information of the Lead
                  Container(
                    width: (MediaQuery.of(context).size.width / 2) - 15,
                    height: constraints.maxWidth >= 930 ? 110 : 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        // This container is where all three buttons are (Edit, Delete, and Go Back)
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: constraints.maxWidth >= 930 ? 50 : 80,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: kColorPearlWhite,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: constraints.maxWidth >= 930
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.contact_mail_rounded,
                                              color: kColorDarkBlue,
                                              size: 30,
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Lead",
                                                  style: kLeadDetailsTextH3,
                                                ),
                                                Text(
                                                  "${Get.find<TableController>().getRecordByFieldType("firstName", Get.arguments['records']).data} ${Get.find<TableController>().getRecordByFieldType("lastName", Get.arguments['records']).data}",
                                                  // '',
                                                  style: kLeadDetailsTextH2,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            RaisedButton(
                                              onPressed: () {
                                                Get.offAllNamed("/EditLeads",
                                                    arguments: {
                                                      'records': Get
                                                          .arguments['records'],
                                                    });
                                              },
                                              color: Colors.white,
                                              child: Text("Edit",
                                                  style: kButtonText1),
                                            ),
                                            RaisedButton(
                                              onPressed: () {
                                                Get.find<RecordController>()
                                                    .deleteRecord(Get
                                                        .arguments['records']);

                                                Get.offAllNamed("/Leads");
                                              },
                                              color: Colors.white,
                                              child: Text(
                                                "Delete",
                                                style: kButtonText1,
                                              ),
                                            ),
                                            RaisedButton(
                                              onPressed: () {
                                                Get.offAllNamed("/Leads");
                                              },
                                              color: Colors.white,
                                              child: Text("Go Back",
                                                  style: kButtonText1),
                                            ),
                                          ],
                                        ),
                                      )
                                    ])
                              : Column(children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.contact_mail_rounded,
                                          color: kColorDarkBlue,
                                          size: 30,
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Lead",
                                              style: kLeadDetailsTextH3,
                                            ),
                                            Text(
                                              "${Get.find<TableController>().getRecordByFieldType("firstName", Get.arguments['records']).data} ${Get.find<TableController>().getRecordByFieldType("lastName", Get.arguments['records']).data}",
                                              // '',
                                              style: kLeadDetailsTextH2,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: constraints.maxWidth >= 590
                                              ? kDefaultButtonSize
                                              : kSmallerButtonSize,
                                          child: RaisedButton(
                                            onPressed: () {
                                              Get.offAllNamed("/EditLeads",
                                                  arguments: {
                                                    'records': Get
                                                        .arguments['records'],
                                                  });
                                            },
                                            color: Colors.white,
                                            child: Text(
                                              "Edit",
                                              style: constraints.maxWidth >= 590
                                                  ? kButtonText1
                                                  : kButtonText4,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: constraints.maxWidth >= 590
                                              ? kDefaultButtonSize
                                              : kSmallerButtonSize,
                                          child: RaisedButton(
                                            onPressed: () {
                                              Get.find<RecordController>()
                                                  .deleteRecord(
                                                      Get.arguments['records']);

                                              Get.offAllNamed("/Leads");
                                            },
                                            color: Colors.white,
                                            child: Text(
                                              "Delete",
                                              style: constraints.maxWidth >= 590
                                                  ? kButtonText1
                                                  : kButtonText4,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: constraints.maxWidth >= 590
                                              ? kDefaultButtonSize
                                              : kSmallerButtonSize,
                                          child: RaisedButton(
                                            onPressed: () {
                                              Get.offAllNamed("/Leads");
                                            },
                                            color: Colors.white,
                                            child: Text(
                                              "Go Back",
                                              style: constraints.maxWidth >= 590
                                                  ? kButtonText1
                                                  : kButtonText4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                        ),
                        // This container is where all Contact Information of the Lead
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          color: Colors.white,
                          child: constraints.maxWidth >= 930
                              ? Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text("Title",
                                            style: kLeadDetailsTextH3),
                                        const SizedBox(height: 18),
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Account Name",
                                            style: kLeadDetailsTextH3),
                                        Text(
                                            "${Get.find<TableController>().getRecordByFieldType("firstName", Get.arguments['records']).data} ${Get.find<TableController>().getRecordByFieldType("lastName", Get.arguments['records']).data}",
                                            style: kLeadDetailsTextH4),
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Phone",
                                            style: kLeadDetailsTextH3),
                                        Text(
                                          Get.find<TableController>()
                                              .getRecordByFieldType(
                                                  "phoneNumber",
                                                  Get.arguments['records'])
                                              .data,
                                          style: kLeadDetailsTextH4,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Email",
                                            style: kLeadDetailsTextH3),
                                        Text(
                                            Get.find<TableController>()
                                                .getRecordByFieldType("email",
                                                    Get.arguments['records'])
                                                .data,
                                            style: kLeadDetailsTextH4),
                                      ],
                                    )
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text("Title",
                                                style: kLeadDetailsTextH5),
                                          ],
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Account Name",
                                                style: kLeadDetailsTextH5),
                                            Text(
                                                "${Get.find<TableController>().getRecordByFieldType("firstName", Get.arguments['records']).data} ${Get.find<TableController>().getRecordByFieldType("lastName", Get.arguments['records']).data}",
                                                style: kLeadDetailsTextH6),
                                          ],
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Phone",
                                                style: kLeadDetailsTextH5),
                                            Text(
                                              Get.find<TableController>()
                                                  .getRecordByFieldType(
                                                      "phoneNumber",
                                                      Get.arguments['records'])
                                                  .data,
                                              style: kLeadDetailsTextH6,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 35,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Email",
                                                style: kLeadDetailsTextH5),
                                            Text(
                                                Get.find<TableController>()
                                                    .getRecordByFieldType(
                                                        "email",
                                                        Get.arguments[
                                                            'records'])
                                                    .data,
                                                style: kLeadDetailsTextH6),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  // This container is for adding the history logs. This is not yet implemented.
                  Container(
                    width: (MediaQuery.of(context).size.width / 2) - 15,
                    height: constraints.maxWidth >= 930 ? 110 : 160,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    // This container is used to add the border inside the box.
                    child: Container(
                      // padding: const EdgeInsets.symmetric(
                      //     horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: kColorDarkBlue,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: kColorPearlWhite,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                            ),
                            child: Row(
                              children: [
                                Obx(
                                  () => SizedBox(
                                    width:
                                        constraints.maxWidth >= 880 ? 130 : 70,
                                    child: FlatButton(
                                      onPressed: () {
                                        Get.find<LogController>()
                                            .currentSection
                                            .value = "call";
                                      },
                                      color: Get.find<LogController>()
                                                  .currentSection
                                                  .value ==
                                              'call'
                                          ? Colors.white
                                          : kColorPearlWhite,
                                      height: 40,
                                      child: Text(
                                        "Log a call",
                                        style: constraints.maxWidth >= 880
                                            ? (Get.find<LogController>()
                                                        .currentSection
                                                        .value ==
                                                    'call'
                                                ? kLeadDetailsTextH4
                                                : kLeadDetailsTextH3)
                                            : (Get.find<LogController>()
                                                        .currentSection
                                                        .value ==
                                                    'call'
                                                ? kLeadDetailsTextH6
                                                : kLeadDetailsTextH5),
                                      ),
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => SizedBox(
                                    width:
                                        constraints.maxWidth >= 880 ? 130 : 70,
                                    child: FlatButton(
                                      onPressed: () {
                                        Get.find<LogController>()
                                            .currentSection
                                            .value = "meeting";
                                      },
                                      color: Get.find<LogController>()
                                                  .currentSection
                                                  .value ==
                                              'meeting'
                                          ? Colors.white
                                          : kColorPearlWhite,
                                      height: 40,
                                      child: Text(
                                        "Log a meeting",
                                        style: constraints.maxWidth >= 880
                                            ? (Get.find<LogController>()
                                                        .currentSection
                                                        .value ==
                                                    'meeting'
                                                ? kLeadDetailsTextH4
                                                : kLeadDetailsTextH3)
                                            : (Get.find<LogController>()
                                                        .currentSection
                                                        .value ==
                                                    'meeting'
                                                ? kLeadDetailsTextH6
                                                : kLeadDetailsTextH5),
                                      ),
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => SizedBox(
                                    width:
                                        constraints.maxWidth >= 880 ? 130 : 62,
                                    child: FlatButton(
                                      onPressed: () {
                                        Get.find<LogController>()
                                            .currentSection
                                            .value = "email";
                                      },
                                      color: Get.find<LogController>()
                                                  .currentSection
                                                  .value ==
                                              'email'
                                          ? Colors.white
                                          : kColorPearlWhite,
                                      height: 40,
                                      child: Text(
                                        "email",
                                        style: constraints.maxWidth >= 880
                                            ? (Get.find<LogController>()
                                                        .currentSection
                                                        .value ==
                                                    'email'
                                                ? kLeadDetailsTextH4
                                                : kLeadDetailsTextH3)
                                            : (Get.find<LogController>()
                                                        .currentSection
                                                        .value ==
                                                    'email'
                                                ? kLeadDetailsTextH6
                                                : kLeadDetailsTextH5),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              // This container is where all the details about a lead are
              Container(
                width: MediaQuery.of(context).size.width - 15,
                height: 700,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                              color: kColorDarkBlue,
                              width: 5,
                            )),
                          ),
                          child: Text(
                            "Details",
                            style: kLeadDetailsTextH1,
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Container(
                        //   decoration: const BoxDecoration(
                        //     border: Border(
                        //         bottom: BorderSide(
                        //       color: Colors.white,
                        //       width: 5,
                        //     )),
                        //   ),
                        //   child: Text(
                        //     "Related",
                        //     style: GoogleFonts.rubik(
                        //         fontSize: 25, fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                      ],
                    ),
                    Container(
                      child: Column(
                        children: [
                          TextFormField(
                            readOnly: true,
                            initialValue:
                                "${Get.find<TableController>().getRecordByFieldType("firstName", Get.arguments['records']).data} ${Get.find<TableController>().getRecordByFieldType("lastName", Get.arguments['records']).data}",
                            // '',
                            decoration: InputDecoration(
                              labelText: "Name",
                              labelStyle: kLeadDetailsTextH3,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Contact Information
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: kColorPearlWhite,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(children: [
                                    InkWell(
                                      onTap: () {
                                        if (Get.find<TableController>()
                                                .showContactInfo
                                                .value ==
                                            false) {
                                          Get.find<TableController>().setToTrue(
                                              Get.find<TableController>()
                                                  .showContactInfo);
                                        } else {
                                          Get.find<TableController>()
                                              .setToFalse(
                                                  Get.find<TableController>()
                                                      .showContactInfo);
                                        }
                                      },
                                      child:
                                          const Icon(Icons.keyboard_arrow_down),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Contact Information",
                                      style: kLeadDetailsTextH3,
                                    ),
                                  ]),
                                ),
                                Obx(() => Get.find<TableController>()
                                            .showContactInfo
                                            .value ==
                                        true
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 50,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                readOnly: true,
                                                initialValue: 'English',
                                                decoration: InputDecoration(
                                                  labelText: "Language",
                                                  labelStyle:
                                                      kLeadDetailsTextH3,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 30),
                                            Expanded(
                                              child: TextFormField(
                                                readOnly: true,
                                                initialValue:
                                                    "${Get.find<TableController>().getRecordByFieldType("firstName", Get.arguments['records']).data} ${Get.find<TableController>().getRecordByFieldType("lastName", Get.arguments['records']).data}",
                                                // '',
                                                decoration: InputDecoration(
                                                  labelText: "Account Name",
                                                  labelStyle:
                                                      kLeadDetailsTextH3,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container())
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Phone and Email
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: kColorPearlWhite,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(children: [
                                    InkWell(
                                      onTap: () {
                                        if (Get.find<TableController>()
                                                .showPhoneandEmail
                                                .value ==
                                            false) {
                                          Get.find<TableController>().setToTrue(
                                              Get.find<TableController>()
                                                  .showPhoneandEmail);
                                        } else {
                                          Get.find<TableController>()
                                              .setToFalse(
                                                  Get.find<TableController>()
                                                      .showPhoneandEmail);
                                        }
                                      },
                                      child:
                                          const Icon(Icons.keyboard_arrow_down),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Phone / Email",
                                      style: kLeadDetailsTextH3,
                                    ),
                                  ]),
                                ),
                                Obx(() => Get.find<TableController>()
                                            .showPhoneandEmail
                                            .value ==
                                        true
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 120,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    readOnly: true,
                                                    initialValue: Get.find<
                                                            TableController>()
                                                        .getRecordByFieldType(
                                                            "phoneNumber",
                                                            Get.arguments[
                                                                'records'])
                                                        .data,
                                                    decoration: InputDecoration(
                                                      labelText: "Phone",
                                                      labelStyle:
                                                          kLeadDetailsTextH3,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 30),
                                                Expanded(
                                                  child: TextFormField(
                                                    readOnly: true,
                                                    initialValue: Get.find<
                                                            TableController>()
                                                        .getRecordByFieldType(
                                                            "email",
                                                            Get.arguments[
                                                                'records'])
                                                        .data,
                                                    decoration: InputDecoration(
                                                      labelText: "Email",
                                                      labelStyle:
                                                          kLeadDetailsTextH3,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 605,
                                              child: TextFormField(
                                                readOnly: true,
                                                initialValue:
                                                    Get.find<TableController>()
                                                        .getRecordByFieldType(
                                                            "mobileNumber",
                                                            Get.arguments[
                                                                'records'])
                                                        .data,
                                                decoration: InputDecoration(
                                                  labelText: "Mobile",
                                                  labelStyle:
                                                      kLeadDetailsTextH3,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container())
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Address Information
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: kColorPearlWhite,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(children: [
                                    InkWell(
                                      onTap: () {
                                        if (Get.find<TableController>()
                                                .showAddressInfo
                                                .value ==
                                            false) {
                                          Get.find<TableController>().setToTrue(
                                              Get.find<TableController>()
                                                  .showAddressInfo);
                                        } else {
                                          Get.find<TableController>()
                                              .setToFalse(
                                                  Get.find<TableController>()
                                                      .showAddressInfo);
                                        }
                                      },
                                      child:
                                          const Icon(Icons.keyboard_arrow_down),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Address Information",
                                      style: kLeadDetailsTextH3,
                                    ),
                                  ]),
                                ),
                                Obx(() => Get.find<TableController>()
                                            .showAddressInfo
                                            .value ==
                                        true
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 190,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextFormField(
                                              readOnly: true,
                                              initialValue: Get.find<
                                                      TableController>()
                                                  .getRecordByFieldType(
                                                      "address1",
                                                      Get.arguments['records'])
                                                  .data,
                                              decoration: InputDecoration(
                                                labelText: "Street Address 2",
                                                labelStyle: kLeadDetailsTextH3,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    readOnly: true,
                                                    initialValue: Get.find<
                                                            TableController>()
                                                        .getRecordByFieldType(
                                                            "city",
                                                            Get.arguments[
                                                                'records'])
                                                        .data,
                                                    decoration: InputDecoration(
                                                      labelText: "City",
                                                      labelStyle:
                                                          GoogleFonts.rubik(
                                                              fontSize: 15),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 30),
                                                Expanded(
                                                  child: TextFormField(
                                                    readOnly: true,
                                                    initialValue: Get.find<
                                                            TableController>()
                                                        .getRecordByFieldType(
                                                            "province",
                                                            Get.arguments[
                                                                'records'])
                                                        .data,
                                                    decoration: InputDecoration(
                                                      labelText: "Province",
                                                      labelStyle:
                                                          kLeadDetailsTextH3,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 605,
                                              child: TextFormField(
                                                readOnly: true,
                                                initialValue:
                                                    Get.find<TableController>()
                                                        .getRecordByFieldType(
                                                            "postal",
                                                            Get.arguments[
                                                                'records'])
                                                        .data,
                                                decoration: InputDecoration(
                                                  labelText: "Postal Code",
                                                  labelStyle:
                                                      kLeadDetailsTextH3,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container())
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              //Container for message box
              // Container(
              //   width: 568,
              //   height: 500,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(5),
              //   ),
              // )
            ],
          );
        }),
      ),
    );
  }
}

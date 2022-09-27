import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:crm/Controllers/mail_controller.dart';
import 'package:crm/Widgets/custom_AppBar.dart';
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
    return Scaffold(
      appBar: CustomAppbar(),
      drawer: Navbar(),
      backgroundColor: kColorDarkBlue,
      body: SingleChildScrollView(
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // This container is where all three buttons are (Edit, Delete, and Go Back) and Contact Information of the Lead
                  Container(
                    width: (MediaQuery.of(context).size.width / 2) - 15,
                    height: constraints.maxWidth > 1030 ? 110 : 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        // This container is where all three buttons are (Edit, Delete, and Go Back)
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: constraints.maxWidth >= 1030 ? 50 : 80,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: kColorPearlWhite,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: constraints.maxWidth >= 1030
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
                                            TextButton(
                                              onPressed: () {
                                                Get.offAllNamed("/EditLeads",
                                                    arguments: {
                                                      'records': Get
                                                          .arguments['records'],
                                                    });
                                              },
                                              style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.white),
                                              child: Text("Edit",
                                                  style: kButtonText1),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                AwesomeDialog(
                                                  context: context,
                                                  width: 370,
                                                  dialogType:
                                                      DialogType.WARNING,
                                                  headerAnimationLoop: false,
                                                  animType: AnimType.SCALE,
                                                  closeIcon: const Icon(Icons
                                                      .close_fullscreen_outlined),
                                                  title: 'Warning',
                                                  titleTextStyle: kTextTitle,
                                                  desc:
                                                      'Are you sure you want to delete this lead?',
                                                  descTextStyle:
                                                      kLeadDetailsTextH3,
                                                  btnCancelOnPress: () {},
                                                  btnOkOnPress: () {
                                                    Get.find<RecordController>()
                                                        .deleteRecord(
                                                            Get.arguments[
                                                                'records']);

                                                    Get.offAllNamed("/Leads");
                                                  },
                                                ).show();
                                              },
                                              style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.white),
                                              child: Text(
                                                "Delete",
                                                style: kButtonText1,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Get.offAllNamed("/Leads");
                                              },
                                              style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.white),
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
                                          child: TextButton(
                                            onPressed: () {
                                              Get.offAllNamed("/EditLeads",
                                                  arguments: {
                                                    'records': Get
                                                        .arguments['records'],
                                                  });
                                            },
                                            style: TextButton.styleFrom(
                                                backgroundColor: Colors.white),
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
                                          child: TextButton(
                                            onPressed: () {
                                              Get.find<RecordController>()
                                                  .deleteRecord(
                                                      Get.arguments['records']);

                                              Get.offAllNamed("/Leads");
                                            },
                                            style: TextButton.styleFrom(
                                                backgroundColor: Colors.white),
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
                                          child: TextButton(
                                            onPressed: () {
                                              Get.offAllNamed("/Leads");
                                            },
                                            style: TextButton.styleFrom(
                                                backgroundColor: Colors.white),
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
                          child: constraints.maxWidth > 1030
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
                                                          Get.arguments[
                                                              'records'])
                                                      .data ==
                                                  'null'
                                              ? "N/A"
                                              : Get.find<TableController>()
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
                                                        .getRecordByFieldType(
                                                            "email",
                                                            Get.arguments[
                                                                'records'])
                                                        .data ==
                                                    'null'
                                                ? 'N/A'
                                                : Get.find<TableController>()
                                                    .getRecordByFieldType(
                                                        "email",
                                                        Get.arguments[
                                                            'records'])
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
                                        const SizedBox(width: 5),
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
                                        const SizedBox(width: 5),
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
                                                              Get.arguments[
                                                                  'records'])
                                                          .data ==
                                                      'null'
                                                  ? 'N/A'
                                                  : Get.find<TableController>()
                                                      .getRecordByFieldType(
                                                          "phoneNumber",
                                                          Get.arguments[
                                                              'records'])
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
                                          width: 29,
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
                                                            .data ==
                                                        'null'
                                                    ? 'N/A'
                                                    : Get.find<
                                                            TableController>()
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
                    height: constraints.maxWidth >= 1030 ? 110 : 160,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    // This container is used to add the border inside the box.
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: kColorDarkBlue,
                          width: 1,
                        ),
                      ),
                      // This is where all the Logs options are (log a call, log a meeting, send email)
                      child: Column(
                        children: [
                          // Container for the the options
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
                                    child: TextButton(
                                      onPressed: () {
                                        Get.find<LogController>()
                                            .currentSection
                                            .value = "call";
                                      },
                                      // color: Get.find<LogController>()
                                      //             .currentSection
                                      //             .value ==
                                      //         'call'
                                      //     ? Colors.white
                                      //     : kColorPearlWhite,
                                      // height: 40,
                                      style: TextButton.styleFrom(
                                          fixedSize: Size.fromHeight(50),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(4))),
                                          backgroundColor:
                                              Get.find<LogController>()
                                                          .currentSection
                                                          .value ==
                                                      'call'
                                                  ? Colors.white
                                                  : kColorPearlWhite),
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
                                    child: TextButton(
                                      onPressed: () {
                                        Get.find<LogController>()
                                            .currentSection
                                            .value = "meeting";
                                      },
                                      // color: Get.find<LogController>()
                                      //             .currentSection
                                      //             .value ==
                                      //         'meeting'
                                      //     ? Colors.white
                                      //     : kColorPearlWhite,
                                      // height: 40,
                                      style: TextButton.styleFrom(
                                          fixedSize: Size.fromHeight(50),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.zero)),
                                          backgroundColor:
                                              Get.find<LogController>()
                                                          .currentSection
                                                          .value ==
                                                      'meeting'
                                                  ? Colors.white
                                                  : kColorPearlWhite),
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
                                    child: TextButton(
                                      onPressed: () {
                                        Get.find<LogController>()
                                            .currentSection
                                            .value = "email";
                                      },
                                      // color: Get.find<LogController>()
                                      //             .currentSection
                                      //             .value ==
                                      //         'email'
                                      //     ? Colors.white
                                      //     : kColorPearlWhite,
                                      // height: 40,
                                      style: TextButton.styleFrom(
                                          fixedSize: Size.fromHeight(50),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.zero)),
                                          backgroundColor:
                                              Get.find<LogController>()
                                                          .currentSection
                                                          .value ==
                                                      'email'
                                                  ? Colors.white
                                                  : kColorPearlWhite),
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
                          ),
                          const SizedBox(height: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(() => Get.find<LogController>()
                                  .showLogContent(Get.arguments['records'])),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              // This container is where all the details about a lead are and sending an email page
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: Get.find<LogController>()
                                .isPressCompossedEmail
                                .value
                            ? 0
                            : 10),

                    // Container for all the details
                    Flexible(
                      flex: 2,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 700,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                ElevatedButton(
                                  onPressed: () {
                                    Get.find<LogController>()
                                        .isPressCompossedEmail
                                        .value = true;
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  child: Text(
                                    'Send an email',
                                    style: kButtonText2,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              child: Column(
                                children: [
                                  TextFormField(
                                    readOnly: true,
                                    initialValue:
                                        "${Get.find<TableController>().getRecordByFieldType("firstName", Get.arguments['records']).data} ${Get.find<TableController>().getRecordByFieldType("lastName", Get.arguments['records']).data}",
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
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: kColorPearlWhite,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Row(children: [
                                            InkWell(
                                              onTap: () {
                                                if (Get.find<TableController>()
                                                        .showContactInfo
                                                        .value ==
                                                    false) {
                                                  Get.find<TableController>()
                                                      .setToTrue(Get.find<
                                                              TableController>()
                                                          .showContactInfo);
                                                } else {
                                                  Get.find<TableController>()
                                                      .setToFalse(Get.find<
                                                              TableController>()
                                                          .showContactInfo);
                                                }
                                              },
                                              child: const Icon(
                                                  Icons.keyboard_arrow_down),
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
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 50,
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                        decoration:
                                                            InputDecoration(
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
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              "Account Name",
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
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: kColorPearlWhite,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Row(children: [
                                            InkWell(
                                              onTap: () {
                                                if (Get.find<TableController>()
                                                        .showPhoneandEmail
                                                        .value ==
                                                    false) {
                                                  Get.find<TableController>()
                                                      .setToTrue(Get.find<
                                                              TableController>()
                                                          .showPhoneandEmail);
                                                } else {
                                                  Get.find<TableController>()
                                                      .setToFalse(Get.find<
                                                              TableController>()
                                                          .showPhoneandEmail);
                                                }
                                              },
                                              child: const Icon(
                                                  Icons.keyboard_arrow_down),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              "Phone / Email",
                                              style: kLeadDetailsTextH3,
                                            ),
                                          ]),
                                        ),
                                        Obx(
                                            () =>
                                                Get.find<TableController>()
                                                            .showPhoneandEmail
                                                            .value ==
                                                        true
                                                    ? Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: 120,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 20),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      TextFormField(
                                                                    readOnly:
                                                                        true,
                                                                    initialValue: Get.find<TableController>().getRecordByFieldType("phoneNumber", Get.arguments['records']).data ==
                                                                            'null'
                                                                        ? 'N/A'
                                                                        : Get.find<TableController>()
                                                                            .getRecordByFieldType("phoneNumber",
                                                                                Get.arguments['records'])
                                                                            .data,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          "Phone",
                                                                      labelStyle:
                                                                          kLeadDetailsTextH3,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 30),
                                                                Expanded(
                                                                  child:
                                                                      TextFormField(
                                                                    readOnly:
                                                                        true,
                                                                    initialValue: Get.find<TableController>().getRecordByFieldType("email", Get.arguments['records']).data ==
                                                                            'null'
                                                                        ? 'N/A'
                                                                        : Get.find<TableController>()
                                                                            .getRecordByFieldType("email",
                                                                                Get.arguments['records'])
                                                                            .data,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          "Email",
                                                                      labelStyle:
                                                                          kLeadDetailsTextH3,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 605,
                                                              child:
                                                                  TextFormField(
                                                                readOnly: true,
                                                                initialValue: Get.find<TableController>()
                                                                            .getRecordByFieldType(
                                                                                "mobileNumber",
                                                                                Get.arguments[
                                                                                    'records'])
                                                                            .data ==
                                                                        'null'
                                                                    ? 'N/A'
                                                                    : Get.find<
                                                                            TableController>()
                                                                        .getRecordByFieldType(
                                                                            "mobileNumber",
                                                                            Get.arguments['records'])
                                                                        .data,
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      "Mobile",
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
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: kColorPearlWhite,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Row(children: [
                                            InkWell(
                                              onTap: () {
                                                if (Get.find<TableController>()
                                                        .showAddressInfo
                                                        .value ==
                                                    false) {
                                                  Get.find<TableController>()
                                                      .setToTrue(Get.find<
                                                              TableController>()
                                                          .showAddressInfo);
                                                } else {
                                                  Get.find<TableController>()
                                                      .setToFalse(Get.find<
                                                              TableController>()
                                                          .showAddressInfo);
                                                }
                                              },
                                              child: const Icon(
                                                  Icons.keyboard_arrow_down),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              "Address Information",
                                              style: kLeadDetailsTextH3,
                                            ),
                                          ]),
                                        ),
                                        Obx(
                                            () =>
                                                Get.find<TableController>()
                                                            .showAddressInfo
                                                            .value ==
                                                        true
                                                    ? Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: 190,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 20),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            TextFormField(
                                                              readOnly: true,
                                                              initialValue: Get.find<
                                                                              TableController>()
                                                                          .getRecordByFieldType(
                                                                              "address1",
                                                                              Get.arguments[
                                                                                  'records'])
                                                                          .data ==
                                                                      'null'
                                                                  ? 'N/A'
                                                                  : Get.find<
                                                                          TableController>()
                                                                      .getRecordByFieldType(
                                                                          "address1",
                                                                          Get.arguments[
                                                                              'records'])
                                                                      .data,
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    "Street Address 1",
                                                                labelStyle:
                                                                    kLeadDetailsTextH3,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      TextFormField(
                                                                    readOnly:
                                                                        true,
                                                                    initialValue: Get.find<TableController>().getRecordByFieldType("city", Get.arguments['records']).data ==
                                                                            'null'
                                                                        ? 'N/A'
                                                                        : Get.find<TableController>()
                                                                            .getRecordByFieldType("city",
                                                                                Get.arguments['records'])
                                                                            .data,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          "City",
                                                                      labelStyle:
                                                                          GoogleFonts.rubik(
                                                                              fontSize: 15),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 30),
                                                                Expanded(
                                                                  child:
                                                                      TextFormField(
                                                                    readOnly:
                                                                        true,
                                                                    initialValue: Get.find<TableController>().getRecordByFieldType("province", Get.arguments['records']).data ==
                                                                            'null'
                                                                        ? 'N/A'
                                                                        : Get.find<TableController>()
                                                                            .getRecordByFieldType("province",
                                                                                Get.arguments['records'])
                                                                            .data,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          "Province",
                                                                      labelStyle:
                                                                          kLeadDetailsTextH3,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 605,
                                                              child:
                                                                  TextFormField(
                                                                readOnly: true,
                                                                initialValue: Get.find<TableController>()
                                                                            .getRecordByFieldType(
                                                                                "postal",
                                                                                Get.arguments[
                                                                                    'records'])
                                                                            .data ==
                                                                        'null'
                                                                    ? "N/A"
                                                                    : Get.find<
                                                                            TableController>()
                                                                        .getRecordByFieldType(
                                                                            "postal",
                                                                            Get.arguments['records'])
                                                                        .data,
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      "Postal Code",
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
                    ),
                    const SizedBox(width: 10),
                    // Container for Email box
                    Get.find<LogController>().isPressCompossedEmail.value
                        ? Flexible(
                            flex: 1,
                            child: Form(
                              key: Get.find<MailController>().mailFormKey,
                              child: Container(
                                width: (MediaQuery.of(context).size.width / 3) -
                                    28,
                                height: 700,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        "Contact",
                                        style: kLeadDetailsTextH1,
                                      ),
                                    ),

                                    const SizedBox(height: 10),
                                    Text(
                                      "Name",
                                      style: kTextSubTitle,
                                    ),
                                    const SizedBox(height: 3),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            initialValue: Get.find<
                                                    TableController>()
                                                .getRecordByFieldType(
                                                    "firstName",
                                                    Get.arguments['records'])
                                                .data,
                                            enabled: false,
                                            decoration: InputDecoration(
                                              labelText: 'First Name',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 1,
                                                    color: kColorDarkBlue),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 1,
                                                    color: kColorDarkBlue),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 1,
                                                    color: kColorDarkBlue),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            onSaved: (value) {
                                              Get.find<MailController>()
                                                  .message
                                                  .value
                                                  .firstName = value.toString();
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: TextFormField(
                                            initialValue: Get.find<
                                                    TableController>()
                                                .getRecordByFieldType(
                                                    "lastName",
                                                    Get.arguments['records'])
                                                .data,
                                            enabled: false,
                                            decoration: InputDecoration(
                                              labelText: 'Last Name',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 1,
                                                    color: kColorDarkBlue),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 1,
                                                    color: kColorDarkBlue),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 1,
                                                    color: kColorDarkBlue),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            onSaved: (value) {
                                              Get.find<MailController>()
                                                  .message
                                                  .value
                                                  .lastName = value.toString();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      "Email",
                                      style: kTextSubTitle,
                                    ),
                                    const SizedBox(height: 3),
                                    TextFormField(
                                      initialValue: Get.find<TableController>()
                                          .getRecordByFieldType(
                                              "email", Get.arguments['records'])
                                          .data,
                                      enabled: false,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1, color: kColorDarkBlue),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1, color: kColorDarkBlue),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1, color: kColorDarkBlue),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      onSaved: (value) {
                                        Get.find<MailController>()
                                            .message
                                            .value
                                            .email = value.toString();
                                      },
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      "Subject",
                                      style: kTextSubTitle,
                                    ),
                                    const SizedBox(height: 3),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Subject',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1, color: kColorDarkBlue),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1, color: kColorDarkBlue),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      onSaved: (value) {
                                        Get.find<MailController>()
                                            .message
                                            .value
                                            .subject = value.toString();
                                      },
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      "Message",
                                      style: kTextSubTitle,
                                    ),
                                    const SizedBox(height: 3),
                                    TextFormField(
                                      maxLines: 12,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1, color: kColorDarkBlue),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1, color: kColorDarkBlue),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      onSaved: (value) {
                                        Get.find<MailController>()
                                            .message
                                            .value
                                            .message = value.toString();
                                      },
                                    ),
                                    // Cancel and Send Button
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.find<LogController>()
                                                .isPressCompossedEmail
                                                .value = false;
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white),
                                          child: Text("Cancel",
                                              style: kButtonText2),
                                        ),
                                        const SizedBox(width: 10),
                                        ElevatedButton(
                                          onPressed: () {
                                            if (Get.find<MailController>()
                                                .mailFormKey
                                                .currentState!
                                                .validate()) {
                                              Get.find<MailController>()
                                                  .mailFormKey
                                                  .currentState!
                                                  .save();

                                              Get.find<MailController>()
                                                  .sendMail();
                                            }

                                            AwesomeDialog(
                                              context: context,
                                              width: 370,
                                              animType: AnimType.SCALE,
                                              headerAnimationLoop: false,
                                              dialogType: DialogType.SUCCES,
                                              title: 'Email sent',
                                              btnOkOnPress: () {
                                                Get.find<LogController>()
                                                    .isPressCompossedEmail
                                                    .value = false;
                                              },
                                              btnOkIcon: Icons.check_circle,
                                              onDissmissCallback: (type) {},
                                            ).show();
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: kColorDarkBlue),
                                          child:
                                              Text("Send", style: kButtonText3),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Text(''),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

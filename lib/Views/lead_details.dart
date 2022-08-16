import 'package:crm/Widgets/navbar.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../Controllers/table_controller.dart';

class LeadDetails extends StatelessWidget {
  // final List<Record> records;
  const LeadDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 56, 91, 133),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Navbar(),
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 219, 217, 217),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.contact_mail_rounded,
                                  color: Color.fromARGB(255, 56, 91, 133),
                                  size: 30,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Contact",
                                      style: GoogleFonts.rubik(fontSize: 15),
                                    ),
                                    Text(
                                      "${Get.find<TableController>().getRecordByFieldType("firstName", Get.arguments['records']).data} ${Get.find<TableController>().getRecordByFieldType("lastName", Get.arguments['records']).data}",
                                      // '',
                                      style: GoogleFonts.rubik(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
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
                                    Get.offAllNamed("/EditLeads", arguments: {
                                      'records': Get.arguments['records'],
                                    });
                                  },
                                  color: Colors.white,
                                  child: Text(
                                    "Edit",
                                    style: GoogleFonts.rubik(
                                      fontSize: 15,
                                      color: const Color.fromARGB(
                                          255, 56, 91, 133),
                                    ),
                                  ),
                                ),
                                RaisedButton(
                                  onPressed: () {},
                                  color: Colors.white,
                                  child: Text(
                                    "Delete",
                                    style: GoogleFonts.rubik(
                                      fontSize: 15,
                                      color: const Color.fromARGB(
                                          255, 56, 91, 133),
                                    ),
                                  ),
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    Get.offAllNamed("/Leads");
                                  },
                                  color: Colors.white,
                                  child: Text(
                                    "Go Back",
                                    style: GoogleFonts.rubik(
                                      fontSize: 15,
                                      color: const Color.fromARGB(
                                          255, 56, 91, 133),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text("Title",
                                style: GoogleFonts.rubik(fontSize: 15)),
                            const SizedBox(height: 18),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Account Name",
                                style: GoogleFonts.rubik(fontSize: 15)),
                            Text(
                              "${Get.find<TableController>().getRecordByFieldType("firstName", Get.arguments['records']).data} ${Get.find<TableController>().getRecordByFieldType("lastName", Get.arguments['records']).data}",
                              // '',
                              style: GoogleFonts.rubik(
                                fontSize: 15,
                                color: const Color.fromARGB(255, 56, 91, 133),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Phone",
                                style: GoogleFonts.rubik(fontSize: 15)),
                            Text(
                              Get.find<TableController>()
                                  .getRecordByFieldType(
                                      "phoneNumber", Get.arguments['records'])
                                  .data,
                              // '',
                              style: GoogleFonts.rubik(
                                fontSize: 15,
                                color: const Color.fromARGB(255, 56, 91, 133),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Email",
                                style: GoogleFonts.rubik(fontSize: 15)),
                            Text(
                              Get.find<TableController>()
                                  .getRecordByFieldType(
                                      "email", Get.arguments['records'])
                                  .data,
                              // '',
                              style: GoogleFonts.rubik(
                                fontSize: 15,
                                color: const Color.fromARGB(255, 56, 91, 133),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 10),
                Container(
                  width: MediaQuery.of(context).size.width - 600,
                  height: MediaQuery.of(context).size.height - 300,
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
                                color: Color.fromARGB(255, 56, 91, 133),
                                width: 5,
                              )),
                            ),
                            child: Text(
                              "Details",
                              style: GoogleFonts.rubik(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                color: Colors.white,
                                width: 5,
                              )),
                            ),
                            child: Text(
                              "Related",
                              style: GoogleFonts.rubik(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
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
                                labelStyle: GoogleFonts.rubik(fontSize: 15),
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
                                      color: const Color.fromARGB(
                                          255, 219, 217, 217),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(children: [
                                      InkWell(
                                        onTap: () {
                                          if (Get.find<TableController>()
                                                  .showContactInfo
                                                  .value ==
                                              false) {
                                            Get.find<TableController>()
                                                .setToTrue(
                                                    Get.find<TableController>()
                                                        .showContactInfo);
                                          } else {
                                            Get.find<TableController>()
                                                .setToFalse(
                                                    Get.find<TableController>()
                                                        .showContactInfo);
                                          }
                                        },
                                        child: const Icon(
                                            Icons.keyboard_arrow_down),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Contact Information",
                                        style: GoogleFonts.rubik(fontSize: 15),
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
                                                        GoogleFonts.rubik(
                                                            fontSize: 15),
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
                                                        GoogleFonts.rubik(
                                                            fontSize: 15),
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
                                      color: const Color.fromARGB(
                                          255, 219, 217, 217),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(children: [
                                      InkWell(
                                        onTap: () {
                                          if (Get.find<TableController>()
                                                  .showPhoneandEmail
                                                  .value ==
                                              false) {
                                            Get.find<TableController>()
                                                .setToTrue(
                                                    Get.find<TableController>()
                                                        .showPhoneandEmail);
                                          } else {
                                            Get.find<TableController>()
                                                .setToFalse(
                                                    Get.find<TableController>()
                                                        .showPhoneandEmail);
                                          }
                                        },
                                        child: const Icon(
                                            Icons.keyboard_arrow_down),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Phone / Email",
                                        style: GoogleFonts.rubik(fontSize: 15),
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
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: "Phone",
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
                                                              "email",
                                                              Get.arguments[
                                                                  'records'])
                                                          .data,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: "Email",
                                                        labelStyle:
                                                            GoogleFonts.rubik(
                                                                fontSize: 15),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 605,
                                                child: TextFormField(
                                                  readOnly: true,
                                                  initialValue: Get.find<
                                                          TableController>()
                                                      .getRecordByFieldType(
                                                          "mobileNumber",
                                                          Get.arguments[
                                                              'records'])
                                                      .data,
                                                  decoration: InputDecoration(
                                                    labelText: "Mobile",
                                                    labelStyle:
                                                        GoogleFonts.rubik(
                                                            fontSize: 15),
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
                                      color: const Color.fromARGB(
                                          255, 219, 217, 217),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(children: [
                                      InkWell(
                                        onTap: () {
                                          if (Get.find<TableController>()
                                                  .showAddressInfo
                                                  .value ==
                                              false) {
                                            Get.find<TableController>()
                                                .setToTrue(
                                                    Get.find<TableController>()
                                                        .showAddressInfo);
                                          } else {
                                            Get.find<TableController>()
                                                .setToFalse(
                                                    Get.find<TableController>()
                                                        .showAddressInfo);
                                          }
                                        },
                                        child: const Icon(
                                            Icons.keyboard_arrow_down),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Address Information",
                                        style: GoogleFonts.rubik(fontSize: 15),
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
                                          height: 260,
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
                                                initialValue:
                                                    Get.find<TableController>()
                                                        .getRecordByFieldType(
                                                            "address1",
                                                            Get.arguments[
                                                                'records'])
                                                        .data,
                                                decoration: InputDecoration(
                                                  labelText: "Street Address 2",
                                                  labelStyle: GoogleFonts.rubik(
                                                      fontSize: 15),
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
                                                      decoration:
                                                          InputDecoration(
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
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: "Province",
                                                        labelStyle:
                                                            GoogleFonts.rubik(
                                                                fontSize: 15),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 605,
                                                child: TextFormField(
                                                  readOnly: true,
                                                  initialValue: Get.find<
                                                          TableController>()
                                                      .getRecordByFieldType(
                                                          "postal",
                                                          Get.arguments[
                                                              'records'])
                                                      .data,
                                                  decoration: InputDecoration(
                                                    labelText: "Postal Code",
                                                    labelStyle:
                                                        GoogleFonts.rubik(
                                                            fontSize: 15),
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
              ],
            )
          ],
        ),
      ),
    );
  }
}

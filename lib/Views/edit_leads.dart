import 'package:crm/Widgets/navbar.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../Controllers/table_controller.dart';
import '../Models/record.dart';

class EditLeads extends StatelessWidget {
  // final List<Record> records;
  const EditLeads({
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
                                  onPressed: () {},
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
                        // RaisedButton(onPressed: () {
                        //   print(Get.arguments['userId']);
                        // }),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Account Name",
                                style: GoogleFonts.rubik(fontSize: 15)),
                            Text(
                              // '${Get.find<TableController>().getRecordByFieldType("lastName", records).data}',
                              "${Get.find<TableController>().getRecordByFieldType("firstName", Get.arguments['records']).data} ${Get.find<TableController>().getRecordByFieldType("lastName", Get.arguments['records']).data}",
                              // Get.find<TableController>().id.value.toString(),

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
            )
          ],
        ),
      ),
    );
  }
}

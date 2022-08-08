import 'package:crm/Bindings/controller_binding.dart';
import 'package:crm/Views/leads.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Controllers/table_controller.dart';

class Navbar extends StatelessWidget {
  Navbar({Key? key}) : super(key: key);
  List<String> pages = ["Leads", "Assets"];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 65,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Blueprint Platform",
            style: GoogleFonts.rubik(
              fontSize: 30,
              color: const Color.fromARGB(255, 56, 91, 133),
            ),
          ),
          Row(
            children: [
              Container(
                width: 200,
                child: RaisedButton(
                  onPressed: () {},
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.apps),
                      Text(
                        "Blueprint Sales",
                        style: GoogleFonts.rubik(
                          fontSize: 20,
                          color: const Color.fromARGB(255, 56, 91, 133),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  if (Get.currentRoute != "/Leads") {
                    Get.offAllNamed("/Leads");
                  }
                },
                color: Colors.white,
                child: Text(
                  "Leads",
                  style: GoogleFonts.rubik(
                      fontSize: 15,
                      color: const Color.fromARGB(255, 56, 91, 133)),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  print(Get.find<TableController>().index);
                },
                color: Colors.white,
                child: Text(
                  "Assets",
                  style: GoogleFonts.rubik(
                      fontSize: 15,
                      color: const Color.fromARGB(255, 56, 91, 133)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

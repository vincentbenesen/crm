import 'package:crm/Controllers/record_controller.dart';
import 'package:crm/Controllers/table_controller.dart';
import 'package:crm/Widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Models/record.dart';

class Leads extends StatelessWidget {
  const Leads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Get.find<RecordController>().fetchRecords(),
        builder: ((context, snapshot) {
          try {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Navbar(),
                    Get.find<TableController>().dataTable(
                      Get.find<TableController>()
                          .getColumns(Get.find<TableController>().leadsColumns),
                      snapshot.data as List<Record>,
                    ),
                  ],
                ),
              ),
            );
          } catch (e) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Navbar(),
                  ],
                ),
              ),
            );
          }
        }));
  }
}

import 'package:crm/constant.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:crm/services/auth_service.dart';

class Navbar extends StatelessWidget {
  Navbar({Key? key}) : super(key: key);
  List<String> pages = ["Leads", "Assets"];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Blueprint Global', style: kUserText),
              accountEmail: Text(
                  AuthService.instance.user.value!.email.toString(),
                  style: kUserText),
              decoration: const BoxDecoration(color: kColorPearlWhite),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: kColorDarkBlue,
                child: ClipOval(
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                if (Get.currentRoute != "/Leads") {
                  Get.offAllNamed("/Leads");
                }
              },
              leading: const Icon(Icons.person),
              title: Text(
                "Leads",
                style: kNavigationText,
              ),
            ),
            ListTile(
              onTap: () {
                AuthService.instance.signOut();
              },
              leading: const Icon(Icons.home),
              title: Text(
                "Assets",
                style: kNavigationText,
              ),
            ),
            ListTile(
              onTap: () {
                AuthService.instance.signOut();
              },
              leading: const Icon(Icons.logout),
              title: Text(
                "Logout",
                style: kNavigationText,
              ),
            ),
          ],
        ),
      ),
    );
    // Container(
    //   width: MediaQuery.of(context).size.width,
    //   height: 65,
    //   color: Colors.white,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text(
    //         "Blueprint Platform",
    //         style: GoogleFonts.rubik(
    //           fontSize: 30,
    //           color: const Color.fromARGB(255, 56, 91, 133),
    //         ),
    //       ),
    //       Row(
    //         children: [
    //           Container(
    //             width: 200,
    //             child: ElevatedButton(
    //               onPressed: () {},
    //               // color: Colors.white,
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 children: [
    //                   Icon(Icons.apps),
    //                   Text(
    //                     "Blueprint Sales",
    //                     style: GoogleFonts.rubik(
    //                       fontSize: 20,
    //                       color: const Color.fromARGB(255, 56, 91, 133),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           ElevatedButton(
    //             onPressed: () {
    //               if (Get.currentRoute != "/Leads") {
    //                 Get.offAllNamed("/Leads");
    //               }
    //             },
    //             // color: Colors.white,
    //             child: Text(
    //               "Leads",
    //               style: GoogleFonts.rubik(
    //                   fontSize: 15,
    //                   color: const Color.fromARGB(255, 56, 91, 133)),
    //             ),
    //           ),
    //           ElevatedButton(
    //             onPressed: () {
    //               AuthService.instance.signOut();
    //             },
    //             // color: Colors.white,
    //             child: Text(
    //               "Logout",
    //               style: GoogleFonts.rubik(
    //                   fontSize: 15,
    //                   color: const Color.fromARGB(255, 56, 91, 133)),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}

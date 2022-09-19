import 'package:crm/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppbar extends StatelessWidget implements PreferredSize {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        iconTheme: const IconThemeData(color: kColorDarkBlue),
        backgroundColor: kColorPearlWhite,
        title: Text(
          "Blueprint Platform",
          style: GoogleFonts.rubik(
            fontSize: 30,
            color: const Color.fromARGB(255, 56, 91, 133),
          ),
        ));
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
}

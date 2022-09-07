import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:crm/Bindings/controller_binding.dart';
import 'package:crm/Views/edit_leads.dart';
import 'package:crm/Views/lead_details.dart';
import 'package:crm/Views/leads.dart';
import 'package:crm/Views/panel.dart';
import 'package:crm/Views/login_page.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    // If some changes happen with the user, it will be notified
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAllNamed('/Login');
    } else {
      Get.offAllNamed('/Leads');
    }
  }

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  Future signIn() async {
    await auth.signInWithEmailAndPassword(
        email: emailTextController.text.trim(),
        password: passwordTextController.text.trim());
  }
}

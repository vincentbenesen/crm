import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;
  late Rx<User?> user = Rx<User?>(auth.currentUser);

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    // If some changes happen with the user, it will be notified
    user.bindStream(auth.userChanges());
    ever(user, _initialScreen);
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

    emailTextController.clear();
    passwordTextController.clear();
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

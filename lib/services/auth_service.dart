import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  static AuthService instance = Get.find();
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

  Future signIn(BuildContext context) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: emailTextController.text.trim(),
          password: passwordTextController.text.trim());
    } on FirebaseAuthException catch (e) {
      showErrorLogin(context, e.toString()).show();
    }

    emailTextController.clear();
    passwordTextController.clear();
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future signUp(BuildContext context) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: emailTextController.text.trim(),
          password: passwordTextController.text.trim());

      Get.offAllNamed('/Login');
    } on FirebaseAuthException catch (e) {
      showErrorLogin(context, e.toString()).show();
    }
    emailTextController.clear();
    passwordTextController.clear();
  }

  AwesomeDialog showErrorLogin(BuildContext context, String errorMessage) {
    return AwesomeDialog(
      context: context,
      width: 370,
      animType: AnimType.SCALE,
      headerAnimationLoop: false,
      dialogType: DialogType.ERROR,
      title: errorMessage.split(']').last,
      btnOkOnPress: () {},
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red,
      onDissmissCallback: (type) {},
    );
  }
}

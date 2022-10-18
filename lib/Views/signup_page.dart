import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'package:crm/constant.dart';
import 'package:crm/services/auth_service.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  var authController = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              kColorDarkBlue,
              Colors.grey,
            ],
          ),
        ),
        child: Center(
          child: Container(
            height: 600,
            width: 500,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
                color: kColorPearlWhite.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Blueprint Platform", style: kLoginTextTitle1),
                const SizedBox(height: 30),
                Text(
                  "Sign Up",
                  style: kLoginTextTitle2,
                ),
                Text(
                  "Register below with your details",
                  style: kLoginTextSubTitle,
                ),
                const SizedBox(height: 30),
                // Email text form field
                TextFormField(
                  controller: authController.emailTextController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Email',
                      fillColor: Colors.white,
                      filled: true),
                ),
                const SizedBox(height: 30),
                // Password text form field
                TextFormField(
                  controller: authController.passwordTextController,
                  obscureText: true,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Password',
                      fillColor: Colors.white,
                      filled: true),
                ),
                const SizedBox(height: 20),
                // Log in button
                ElevatedButton(
                  onPressed: () {
                    authController.signUp(context);
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text("Sign Up", style: kButtonText2),
                ),

                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Get.offAndToNamed("/Login");
                  },
                  child: Text(
                    "Log In",
                    style: kLoginTextSubTitle,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

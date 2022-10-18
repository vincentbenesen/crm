import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'package:crm/constant.dart';
import 'package:crm/services/auth_service.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

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
                  "Login",
                  style: kLoginTextTitle2,
                ),
                Text(
                  "Please your Email and Password",
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
                    authController.signIn(context);
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  // color: Colors.white,
                  child: Text("Login", style: kButtonText2),
                ),

                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Get.offAndToNamed("/SignUp");
                  },
                  child: Text(
                    "Sign Up",
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

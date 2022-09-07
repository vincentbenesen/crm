import 'package:crm/Controllers/auth_controller.dart';
import 'package:crm/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorDarkBlue,
      body: Center(
        child: Container(
          height: 600,
          width: 500,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: kColorPearlWhite.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: Get.find<AuthController>().emailTextController,
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
              const SizedBox(height: 10),
              TextFormField(
                controller: Get.find<AuthController>().passwordTextController,
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
              RaisedButton(onPressed: () {
                Get.find<AuthController>().signIn();
              })
            ],
          ),
        ),
      ),
    );
  }
}

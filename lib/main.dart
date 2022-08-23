import 'package:crm/Views/edit_leads.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:crm/routes/routes.dart';
import 'package:crm/constant.dart';
import 'Models/record.dart';
import 'Views/lead_details.dart';
import 'Views/panel.dart';
import 'package:crm/Views/leads.dart';
import 'Bindings/controller_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: kApiKey,
          authDomain: kAuthDomain,
          projectId: kProjectId,
          storageBucket: kStorageBucket,
          messagingSenderId: kMessagingSenderId,
          appId: kAppId));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.getInitialRoute(),
        initialBinding: ControllerBinding(),
        getPages: Routes.routes);
  }
}

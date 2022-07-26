import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './panel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAipwchueYRMQhdswHq-HvbnQOXWIf5DN8",
          authDomain: "fir-flutter-479eb.firebaseapp.com",
          projectId: "fir-flutter-479eb",
          storageBucket: "fir-flutter-479eb.appspot.com",
          messagingSenderId: "985079857939",
          appId: "1:985079857939:web:e3106b184d8d5affc450e6"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Panel(),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parenthood/Views/home_view.dart';
import 'package:get/get.dart';
import 'package:parenthood/Views/signup_view.dart';
import 'package:parenthood/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    print(e);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

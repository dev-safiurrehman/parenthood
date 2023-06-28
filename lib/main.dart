// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:parenthood/Controllers/auth_controller.dart';
// import 'package:parenthood/Views/WelcomeView.dart';
// import 'package:parenthood/Views/home_view.dart';
// import 'package:get/get.dart';
// import 'package:parenthood/Views/login_view.dart';
// import 'package:parenthood/Views/signup_view.dart';
// import 'package:parenthood/Widgets/AuthMiddleware.dart';
// import 'package:parenthood/firebase_options.dart';
//
// import 'Controllers/todo_controller.dart';
// import 'Controllers/user_controller.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   } catch (e) {
//     print(e);
//   }
//   runApp(MyApp());
// // Add this line
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Parenthood',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       initialRoute: '/',
//       getPages: [
//         GetPage(
//           name: '/',
//           page: () => WelcomeView(),
//         ),
//         GetPage(
//           name: '/signup',
//           page: () => SignUpView(),
//         ),
//         GetPage(
//           name: '/login',
//           page: () => LoginView(),
//         ),
//         GetPage(
//           name: '/home',
//           page: () => HomeView(),
//           middlewares: [
//             AuthMiddleware(),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parenthood/Views/login_view.dart';
import 'package:parenthood/views/todo_view.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    print(e);
  }
  runApp(TodoApp());
}

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  bool signedIn = false;
  @override
  void initState() {
    super.initState();
    // Disable persistence on web platforms
    FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
    _auth.authStateChanges().listen((user) {
      // check if user is signed in
      if (user != null) {
        setState(() {
          signedIn = true;
        });
      } else {
        setState(() {
          signedIn = false;
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(239, 244, 253, 1),

          appBarTheme: const AppBarTheme(

            iconTheme: IconThemeData(
              color: Color.fromRGBO(84, 110, 149, 1),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ), //for lightmode
        darkTheme: ThemeData(
          //for darkmode
          brightness: Brightness.dark,
        ),
        //check if user is signed in or not and navigate to the appropriate page
        home: signedIn ? TodoView() : LoginView());
  }
}
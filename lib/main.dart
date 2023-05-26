// import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mvblooddonationapp/home.dart';
import 'package:mvblooddonationapp/services/notification.dart';
import 'package:mvblooddonationapp/signupform.dart';
import 'package:mvblooddonationapp/splash.dart';
import 'package:mvblooddonationapp/userpage.dart';

import 'loginpage.dart';

// late Size mq;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  await Firebase.initializeApp();

  runApp(MaterialApp(
    theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFE11607),
            primary: const Color.fromARGB(255, 225, 22, 7))),
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => const Splash(),
      '/user': (context) => const UserPage(),
      '/signupform': (context) => const SignUp(),
      '/loginform': (context) => const Login(),
      '/home': (context) => const HomePage(),
    },
  ));
}

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sheknows_app/Screens/DashBoard/home.dart';
import 'package:sheknows_app/Screens/SignUp/signup_screen.dart';
import 'package:sheknows_app/Screens/Welcome/welcome_screen.dart';
import 'package:sheknows_app/constant.dart';
import 'package:sheknows_app/splash_screen.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // final file = File('.env');
  // print("Does .env file exist? ${await file.exists()}");
  // await dotenv.load(fileName: ".env");
  FirebaseAuth.instance.setLanguageCode("en");

  //   Status bar ko transparent kar diya
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SheKnows App',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home:  SplashScreenWrapper(),
      routes: {
        '/SignInScreen': (context) =>   SignUpScreen(),
        '/welcomeScreen': (context) =>   WelcomeScreen(),
      },
    );
  }
}

// SafeArea + Background fix
class SplashScreenWrapper extends StatelessWidget {
  const SplashScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SplashScreen(),
      ),
    );
  }
}


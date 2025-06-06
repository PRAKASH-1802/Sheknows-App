import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sheknows_app/Screens/DashBoard/home.dart';
import 'package:sheknows_app/Services/auth.dart';
import 'package:sheknows_app/constant.dart';

import 'package:sheknows_app/Component/already_have_an_account_check.dart';
import 'package:sheknows_app/Component/rounded_button.dart';
import 'package:sheknows_app/Component/rounded_input_field.dart';
import 'package:sheknows_app/Component/rounded_password_field.dart';
import 'package:sheknows_app/Screens/Login/components/background.dart';
import 'package:sheknows_app/Screens/SignUp/signup_screen.dart';
import 'package:sheknows_app/loading.dart';
//import 'package:sheknows_app/services/auth_service.dart'; // Ensure AuthService is properly implemented

class Body extends StatefulWidget {
   Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? email, pswd;
  bool loading = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  final AuthService _auth = AuthService(); // Initialize AuthService

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Background(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "LOGIN",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 30,
                          height: 17),
                    ),
                    RoundedInputField(
                      hintText: "Your Email",
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    RoundedPasswordField(
                      onChanged: (value) {
                        setState(() {
                          pswd = value;
                        });
                      },
                    ),
                    RoundedButton(
                      text: "LOGIN",
                      press: () async {
                        if (email == null || email!.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Email cannot be empty!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: kPrimaryLightColor,
                              textColor: Colors.black,
                              fontSize: 16.0);
                        } else if (pswd == null || pswd!.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Password cannot be empty!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: kPrimaryLightColor,
                              textColor: Colors.black,
                              fontSize: 16.0);
                        } else if (pswd!.length < 6) {
                          Fluttertoast.showToast(
                              msg:
                                  "Password should be atlest 6 characters long!!",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: kPrimaryLightColor,
                              textColor: Colors.black,
                              fontSize: 12.0);
                        } else {
                          setState(() => loading = true);

                          AppUser? result = await
                              _auth.signInWithEmailAndPassword(email!, pswd!);

                          print("REsult: " + result.toString());
                          if (result != null) {
                            print("Login Successful. Navigating to Home Page...");
                            setState(() {
                              loading = false;
                            });


                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Home(email: email!);
                                },
                              ),
                            );
                          }
                          else {
                            setState(() {
                              loading = false;
                            });
                            Fluttertoast.showToast(
                                msg: "Error in Signing In..Try Again!!",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.redAccent[100],
                                textColor: Colors.white,
                                fontSize: 12.0);
                            // Navigator.of(context).pushNamedAndRemoveUntil("/homeScreen", (route) => false);
                          }
                        }
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    AlreadyHaveAnAccountCheck(
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

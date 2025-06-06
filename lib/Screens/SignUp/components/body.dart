import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sheknows_app/Screens/Login/login_screen.dart';
import 'package:sheknows_app/Screens/Signup/components/background.dart';
import 'package:sheknows_app/Component/already_have_an_account_check.dart';
import 'package:sheknows_app/Component/rounded_password_field.dart';
import 'package:sheknows_app/Services/auth.dart';
import 'package:sheknows_app/constant.dart';
import 'package:sheknows_app/loading.dart';

import '../../../Component/rounded_button.dart';
import '../../../Component/rounded_input_field.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String name, email, pswd, error = "";
  bool loading = false;

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Background(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "SIGNUP",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Image.asset(
                    "assets/images/m3.png",
                    height: size.height * 0.20,
                  ),
                  RoundedInputField(
                      hintText: "Your Name",
                      onChanged: (value) {
                        name = value;
                      }),
                  RoundedInputField(
                    hintText: "Your Email",
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  RoundedPasswordField(
                    onChanged: (value) {
                      pswd = value;
                    },
                  ),
                  RoundedButton(
                      text: "SignUp",
                      press: () async {
                        if (email == null || email == "") {
                          Fluttertoast.showToast(
                              msg: "Email cannot be empty!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: kPrimaryLightColor,
                              textColor: Colors.black,
                              fontSize: 16.0);
                        } else if (pswd == null || pswd == "") {
                          Fluttertoast.showToast(
                              msg: "Password cannot be empty!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: kPrimaryLightColor,
                              textColor: Colors.black,
                              fontSize: 16.0);
                        } else if (pswd.length < 6) {
                          Fluttertoast.showToast(
                              msg:
                                  "Password should be at least 6 characters long!!",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: kPrimaryLightColor,
                              textColor: Colors.black,
                              fontSize: 12.0);
                        } else {
                          setState(() {
                            loading = true;
                          });

                          dynamic result = await _auth
                              .registerWithEmailAndPassword(name, email, pswd);

                          // setState(() {
                          //   loading = false;
                          // });

                          // if (result != null) {
                          //
                          //   //  User ka naam Firebase me update karo
                          //   // await result.user?.updateProfile(displayName: name);
                          //   // await result.user?.reload();
                          //   // print(
                          //   //     "User Name Updated: ${result.user?.displayName}");
                          //
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) {
                          //         return LoginScreen();
                          //       },
                          //     ),
                          //   );

                          if (result != null) {
                            User? user = FirebaseAuth.instance.currentUser;

                            await user?.updateProfile(displayName: name); // ✅ Ensure update is awaited
                            await user?.reload();  // ✅ Ensure latest data
                            user = FirebaseAuth.instance.currentUser; // ✅ Reload updated user data
                            print("User Name Updated: ${user?.displayName}");

                          // ✅ Use `pushReplacement` instead of `push` to prevent going back to signup screen
                            Navigator.pushReplacement(
                            context,
                               MaterialPageRoute(
                                  builder: (context) {
                                    return LoginScreen();
                                  },
                              ),
                            );
                          }
                          else {
                            setState(() {
                              loading = false;
                            });

                            Fluttertoast.showToast(
                                msg: "Error in Signing Up..Try Again!!",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.redAccent[100],
                                textColor: Colors.white,
                                fontSize: 12.0);
                          }
                        }
                      }),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
  }
}

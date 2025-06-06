import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sheknows_app/Component/rounded_button.dart';
import 'package:sheknows_app/Screens/Login/login_screen.dart';
import 'package:sheknows_app/Screens/SignUp/signup_screen.dart';
import 'package:sheknows_app/Screens/Welcome/components/background.dart';
import 'package:sheknows_app/constant.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "WELCOME TO SHEKNOWS",

              style: TextStyle(fontWeight: FontWeight.w900,
                  fontSize: 24, color: Colors.white,
                  height: 20),
            ),
            SizedBox(height: 25),
            // RoundedButton(text: "LOGIN", press: () {}),
            // RoundedButton(text: "SIGN UP", press: () {}),
            // SizedBox(height: size.height * 0.05),

            // SvgPicture.asset(
            //   "assets/icon/welcome.svg",
            //   height: size.height * 0.45,
            // ),
            // SizedBox(height: size.height * 0.16),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => LoginScreen()),
            //     );
            //   },
            //   child: Text("LOGIN",   ),
            //
            // ),

            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => SignUpScreen()));
            //     },
            //     child: Text("SIGN UP", ),
            //
            // ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LoginScreen(),
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              // color: kPrimaryLightColor,
              // textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sheknows_app/Services/database.dart';

class Suggestion extends StatefulWidget {
  @override
  _SuggestionState createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late String uid1;

  void uidOfUser() async {
    User? user = auth.currentUser;
    if (user != null) {
      uid1 = user.uid;
    } else {
      Fluttertoast.showToast(
        msg: "User not found. Please log in again.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    uidOfUser();
  }

  late String suggestion;
  DatabaseService db = DatabaseService(uid: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 60,
        backgroundColor: Colors.lightGreenAccent,
        title: Text(
          "Write Suggestion",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            Text(
              "Write us your valuable Suggestion...",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please provide a suggestion';
                }
                return null;
              },
              onChanged: (val) {
                suggestion = val;
              },
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () async {
                  uidOfUser();
                  if (uid1.isNotEmpty) {
                    var result = await db.addSuggestion(suggestion, uid1);

                    Fluttertoast.showToast(
                      msg: "Thank you for your suggestion. It means a lot to us :)",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      fontSize: 18.0,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.lightBlueAccent,
                ),
                child: Text(
                  "Send it !!!!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

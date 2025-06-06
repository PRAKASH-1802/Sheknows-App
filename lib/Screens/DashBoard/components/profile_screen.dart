// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sheknows_app/Screens/DashBoard/components/ComponentHealth/aboutscreen.dart';
// import 'package:sheknows_app/Screens/DashBoard/components/ComponentHealth/myorder.dart';
// import 'package:sheknows_app/Screens/DashBoard/components/ComponentHealth/privacypolicy.dart';
// import 'package:sheknows_app/Screens/DashBoard/components/ComponentHealth/suggestion.dart';
// import 'package:sheknows_app/Screens/DashBoard/components/ComponentHealth/termcondition.dart';
// import 'package:sheknows_app/Screens/DashBoard/components/ComponentHealth/viewcart.dart';
// import 'package:sheknows_app/Services/auth.dart';
// import 'package:sheknows_app/Services/database.dart';
//
// class ProfileScreen extends StatefulWidget {
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   String userName = " ";
//
//   DatabaseService db = DatabaseService(uid: '');
//   late SharedPreferences prefs;
//   AuthService a = AuthService();
//   FirebaseAuth _auth = FirebaseAuth.instance;
//
//   User? user;
//   String? email;
//
//   getUid() async {
//     user = _auth.currentUser;
//     email = user?.email;
//     print(email);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getUid();
//     getUserInfo();
//   }
//
//   Future<void> getUserInfo() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     await user?.reload();
//
//     if (user != null) {
//       print("User UID: ${user.uid}");
//       print("User Name from Firebase: ${user.displayName}");
//
//       setState(() {
//         userName = user.displayName ?? "Name Not Available";
//       });
//     } else {
//       setState(() {
//         userName = "User not logged in";
//       });
//     }
//   }
//
//   FirebaseAuth auth = FirebaseAuth.instance;
//
//   void askToLogout(BuildContext context) {
//     var alertDialog = AlertDialog(
//       title: Text("Are you sure you want to logout?"),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop(false);
//           },
//           child: Text("NO"),
//         ),
//         TextButton(
//           onPressed: () {
//             auth.signOut();
//             Navigator.of(context).pushNamedAndRemoveUntil(
//                 '/welcomeScreen', (Route<dynamic> route) => false);
//           },
//           child: Text("YES"),
//         ),
//       ],
//     );
//
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return alertDialog;
//         });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         toolbarHeight: 5,
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(10),
//         children: [
//           //  User name Section
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 3,
//                   blurRadius: 5,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: ListTile(
//               contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 11),
//               leading: Icon(Icons.account_circle, size: 65, color: Colors.blue),
//               title: Text(
//                 "$userName",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//
//           SizedBox(height: 20,),
//           ListTile(
//               onTap: (){
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context){
//                       return ViewCart();
//                     }));
//               },
//               leading: Icon(Icons.shopping_cart, color: Colors.pinkAccent,),
//               title:Text("My cart",style: TextStyle(
//                 fontSize: 18, fontWeight: FontWeight.w500,
//               ),)
//           ),
//
//           SizedBox(height: 20,),
//           ListTile(
//               onTap: (){
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context){
//                       return MyOrders();
//                     }));
//               },
//               leading: Icon(Icons.all_inbox, color: Colors.blue,),
//               title:Text("Orders",style: TextStyle(
//                 fontSize: 18, fontWeight: FontWeight.w500,
//               ),)
//           ),
//
//           SizedBox(height: 20,),
//           ListTile(
//               onTap: (){
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context){
//                       return Suggestion();
//                     }));
//               },
//               leading: Icon(Icons.tips_and_updates_outlined, color: Colors.yellow),
//               title:Text("Suggestion",style: TextStyle(
//                 fontSize: 18, fontWeight: FontWeight.w500,
//               ),)
//           ),
//
//           SizedBox(height: 20),
//           ListTile(
//               onTap: (){
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context){
//                       return AboutScreen();
//                     }));
//               },
//               leading: Icon(Icons.info_outline_rounded, color: Colors.lightGreen,),
//               title:Text("About Us",style: TextStyle(
//                 fontSize: 18, fontWeight: FontWeight.w500
//               ),)
//           ),
//
//           SizedBox(height: 20),
//           ListTile(
//               onTap: (){
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context){
//                       return PrivacyPolicyScreen();
//                     }));
//               },
//               leading: Icon(Icons.privacy_tip_outlined, color: Colors.red[500],),
//               title:Text("Privacy Policy",style: TextStyle(
//                 fontSize: 18, fontWeight: FontWeight.w500
//               ),)
//           ),
//
//           SizedBox(height: 20),
//           ListTile(
//               onTap: (){
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context){
//                       return TermsAndConditionsScreen();
//                     }));
//               },
//               leading: Icon(Icons.description_outlined, color: Colors.pink[900]),
//               title:Text("Terms & Conditions",style: TextStyle(
//                 fontSize: 18, fontWeight: FontWeight.w500
//               ),)
//           ),
//
//           SizedBox(height: 100),
//
//           // Logout Button Section
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 3,
//                   blurRadius: 5,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Align(
//               alignment: Alignment.center,
//               child: ListTile(
//
//                 onTap: () {
//                   askToLogout(context);
//                 },
//                 contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 150),
//                 leading: Icon(Icons.power_settings_new, size: 30, color: Colors.redAccent),
//                 title: Text(
//                   "Logout",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.redAccent,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sheknows_app/Screens/DashBoard/components/ComponentHealth/aboutscreen.dart';
import 'package:sheknows_app/Screens/DashBoard/components/ComponentHealth/myorder.dart';
import 'package:sheknows_app/Screens/DashBoard/components/ComponentHealth/privacypolicy.dart';
import 'package:sheknows_app/Screens/DashBoard/components/ComponentHealth/suggestion.dart';
import 'package:sheknows_app/Screens/DashBoard/components/ComponentHealth/termcondition.dart';
import 'package:sheknows_app/Screens/DashBoard/components/ComponentHealth/viewcart.dart';
import 'package:sheknows_app/Screens/DashBoard/components/chatbot_screen.dart';
// import 'package:sheknows_app/Screens/DashBoard/components/home_screen.dart';
import 'package:sheknows_app/Screens/DashBoard/home.dart';
import 'package:sheknows_app/Services/auth.dart';
import 'package:sheknows_app/Services/database.dart';
// import 'package:sheknows_app/Screens/DashBoard/dashboard.dart'; // Import your DashBoard screen

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = " ";

  DatabaseService db = DatabaseService(uid: '');
  late SharedPreferences prefs;
  AuthService a = AuthService();
  FirebaseAuth _auth = FirebaseAuth.instance;

  User? user;
  String? email;

  getUid() async {
    user = _auth.currentUser;
    email = user?.email;
    print(email);
  }

  @override
  void initState() {
    super.initState();
    getUid();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload();

    if (user != null) {
      print("User UID: ${user.uid}");
      print("User Name from Firebase: ${user.displayName}");

      setState(() {
        userName = user.displayName ?? "Name Not Available";
        db = DatabaseService(uid: user.uid); // Initialize DatabaseService with UID
      });
    } else {
      setState(() {
        userName = "User not logged in";
      });
    }
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  void askToLogout(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("Are you sure you want to logout?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text("NO"),
        ),
        TextButton(
          onPressed: () {
            auth.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/welcomeScreen', (Route<dynamic> route) => false);
          },
          child: Text("YES"),
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate to DashBoard when the back button is pressed
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Home(email: '',)),
        );
        return false; // Prevent default back button behavior
      },

      child: Scaffold(
        appBar: AppBar(
          // Removed automaticallyImplyLeading: false to show the default back button
          title: Text(
            "Profile",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.purpleAccent.shade100,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navigate to DashBoard when the AppBar back button is pressed
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Home(email: '',)),
              );
            },
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            // User name Section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding:
                EdgeInsets.symmetric(vertical: 10, horizontal: 11),
                leading: Icon(Icons.account_circle,
                    size: 65, color: Colors.blue),
                title: Text(
                  "$userName",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ViewCart()),
                );
              },
              leading: Icon(Icons.shopping_cart, color: Colors.pinkAccent),
              title: Text(
                "My cart",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SizedBox(height: 20),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MyOrders()),
                );
              },
              leading: Icon(Icons.all_inbox, color: Colors.blue),
              title: Text(
                "Orders",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SizedBox(height: 20),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AskQuestionScreen()),
                );
              },
              leading: Icon(Icons.chat_outlined, color: Colors.blue),
              title: Text(
                "Ask_ Question",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SizedBox(height: 20),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Suggestion()),
                );
              },
              leading: Icon(Icons.tips_and_updates_outlined,
                  color: Colors.yellow),
              title: Text(
                "Suggestion",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SizedBox(height: 20),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AboutScreen()),
                );
              },
              leading: Icon(Icons.info_outline_rounded,
                  color: Colors.lightGreen),
              title: Text(
                "About Us",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SizedBox(height: 20),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => PrivacyPolicyScreen()),
                );
              },
              leading: Icon(Icons.privacy_tip_outlined,
                  color: Colors.red[500]),
              title: Text(
                "Privacy Policy",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SizedBox(height: 20),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => TermsAndConditionsScreen()),
                );
              },
              leading: Icon(Icons.description_outlined,
                  color: Colors.pink[900]),
              title: Text(
                "Terms & Conditions",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SizedBox(height: 100),

            // Logout Button Section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.center,
                child: ListTile(
                  onTap: () {
                    askToLogout(context);
                  },
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 150),
                  leading: Icon(Icons.power_settings_new,
                      size: 30, color: Colors.redAccent),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
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

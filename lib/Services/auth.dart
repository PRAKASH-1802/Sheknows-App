import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:sheknows_app/Services/database.dart';
import 'package:sheknows_app/models/user.dart';
import 'package:sheknows_app/Screens/Login/components/body.dart';

// class AppUser {
//   final String uid;
//   AppUser({required this.uid});
//
// }
class AppUser {
  String? uid;
  String? email;
  String? name;

  AppUser({this.uid, this.email, this.name});
}


class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  // Create user object based on Firebase user
  AppUser? _userFromFirebase(auth.User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  // Sign in anonymously
  Future<AppUser?> signInAnon() async {
    try {
      auth.UserCredential authResult = await _auth.signInAnonymously();
      auth.User? user = authResult.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with email and password
  Future<AppUser?> signInWithEmailAndPassword(String email, String password) async {
    try {
      auth.UserCredential authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      auth.User? user = authResult.user;

      if (user != null) {
        // if (!user.emailVerified) {
        //   print("User email not verified");
        //   return null;  // Agar email verified nahi hai toh null return karega
        // }
        print("User logged in successfully: ${user.uid}");
        return _userFromFirebase(user);
      } else {
        print("User is null after sign-in.");
        return null;
      }
    } catch (e) {
      print("Sign-In Error: ${e.toString()}");  // Yeh line error ko properly print karegi
      return null;
    }
  }


  // Register with email and password
  Future<AppUser?> registerWithEmailAndPassword(String name, String email, String password) async {
    try {
      auth.UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      auth.User? user = authResult.user;

      if (user != null) {
        await user.sendEmailVerification();
        await DatabaseService(uid: user.uid).updateUserData(name, email);

        print("User Created: ${user.uid}");

        return _userFromFirebase(user);  //  Ensure user is returned
      }
      return null;
    } catch (e) {
      print("Registration Error: ${e.toString()}");  //  Print Error Properly
      return null;
    }
  }


  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Sign out error: " + e.toString());
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hungryhub/view/authentication/authenticate.dart';

import '../view/authentication/view/sign_in.dart';
import '../view/authentication/view/signup.dart';
import '../view/Home/home.dart';

late final int istaps;

class GoogleSignInProvider with ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  int istap = 1;

  GoogleSignInAccount get user => _user!;
  Future googleLogIn(context) async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e);
      // ignore: unnecessary_null_comparison
      if (e.code == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 300),
            content: Text("Email doesn't Exist"),
          ),
        );
      }
    }
    notifyListeners();
  }

  Future logOutWithGoogle(context) async {
    if (checks == false) {
      print('qqqqq');
      await googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
    } else if (checks == true) {
      print('aaaaaa');
      FirebaseAuth.instance.signOut().then((value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Authenticate(),
            ));
      });
    }

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const SignIn(),
    //   ),
    // );
    // });
    notifyListeners();
  }

  Future logOut(context) async {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Authenticate(),
          ));
    });
    print('sign out');

    notifyListeners();
  }

  Future<void> sigIn(context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailcontrol.text.trim(),
              password: passwordcontrol.text.trim())
          .then((value) {
        print("successfull login");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 300),
            content: Text("Email doesn't Exist"),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 300),
            content: Text("password doesn't Exist"),
          ),
        );
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 300),
            content: Text("invalid-email"),
          ),
        );
      }
    }
    notifyListeners();
  }

//  ------------SIgnUp-----------------\\

  Future<void> signUp(context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailcontrol.text, password: passwordcontrol.text)
          .then((value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 300),
            content: Text("invalid-email"),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 300),
            content: Text("email already exist please Login"),
          ),
        );
      } else if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 300),
            content: Text("Password is Too Weak"),
          ),
        );
        print(e);
      }
    }
    notifyListeners();
  }
}

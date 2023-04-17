import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hungryhub/controller/services/authenticate.dart';
import 'package:hungryhub/view/authentication/signup.dart';
import 'package:hungryhub/view/widgets/bottom_nav.dart';

import '../../view/Home/home.dart';
import '../../view/authentication/forgott_pass.dart';
import '../../view/authentication/sign_in.dart';

late final int istaps;

class AuthenticateProvider with ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  int istap = 1;

// --------GoogleLogin------------//
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
  //------logOutwithgoogle-------------//

  Future logOutWithGoogle(context) async {
    if (checks == false) {
      await googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
    } else if (checks == true) {
      FirebaseAuth.instance.signOut().then((value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Authenticate(),
            ));
      });
    }
    notifyListeners();
  }

//-------------logout--------//
  Future logOut(context) async {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Authenticate(),
          ));
    });

    notifyListeners();
  }

//--------------SignIn------------//

  Future<void> sigIn(context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailcontrol.text.trim(),
              password: passwordcontrol.text.trim())
          .then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNav(),
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
      }
    }
    notifyListeners();
  }

  //--------forgot password---------//

  Future forgotPassword(context) async {
    try {
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: forgotpasscontrol.text)
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'We Have Send a Link To Reset Your Password',
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignIn(),
          ),
        );
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error.toString(),
            ),
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      return e;
    }
    notifyListeners();
  }
}

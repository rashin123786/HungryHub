import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:hungryhub/UI/authentication/view/sign_in.dart';
import 'package:hungryhub/UI/home.dart';

import 'view/signup.dart';

class Authenticate extends StatelessWidget {
  const Authenticate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        } else {
          return const SignIn();
        }
      },
    );
  }
}

//  --------------SIGNIn---------------\\

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
}

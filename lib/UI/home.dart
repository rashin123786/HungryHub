import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:hungryhub/UI/authentication/view/sign_in.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text(user.email!),
          Center(
            child: TextButton(
              child: const Text(
                'logout',
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  print('sign out');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignIn(),
                    ),
                  );
                });
              },
            ),
          ),
        ],
      )),
    );
  }
}

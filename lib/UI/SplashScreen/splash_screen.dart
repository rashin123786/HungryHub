import 'dart:async';

import 'package:flutter/material.dart';

import '../authentication/authenticate.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Authenticate(),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 235, 218, 1),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/splash2.gif',
            ),
            fit: BoxFit.contain,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.only(top: 180, left: 70),
          child: Text(
            '𝐇𝐮𝐧𝐠𝐫𝐲𝐇𝐮𝐛',
            style: TextStyle(
              color: Colors.black,
              fontSize: 50,
            ),
          ),
        ),
      ),
    );
  }
}

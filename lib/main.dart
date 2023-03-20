import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hungryhub/UI/SplashScreen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HungryHub());
}

class HungryHub extends StatelessWidget {
  const HungryHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.grey,
          appBarTheme: const AppBarTheme(
            color: Colors.redAccent,
          )),
      home: const SplashScreen(),
    );
  }
}

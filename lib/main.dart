import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hungryhub/UI/SplashScreen/splash_screen.dart';
import 'package:provider/provider.dart';

import 'controlls/authentication.dart';
import 'controlls/bottom_nav_controler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HungryHub());
}

class HungryHub extends StatelessWidget {
  const HungryHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomNavController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.grey,
            appBarTheme: const AppBarTheme(
              color: Colors.orange,
            )),
        home: const SplashScreen(),
      ),
    );
  }
}

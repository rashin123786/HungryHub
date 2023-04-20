import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hungryhub/controller/provider/add_address.dart';
import 'package:hungryhub/controller/provider/authentication.dart';
import 'package:hungryhub/controller/provider/bottom_nav_controler.dart';
import 'package:hungryhub/controller/provider/cart_list_controller.dart';
import 'package:hungryhub/controller/provider/payment_controller.dart';
import 'package:hungryhub/controller/provider/search_controller.dart';

import 'package:hungryhub/controller/provider/wish_list_controller.dart';
import 'package:hungryhub/view/SplashScreen/splash_screen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const HungryHub());
}

class HungryHub extends StatelessWidget {
  const HungryHub({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthenticateProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomNavController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProductControll(),
        ),
        ChangeNotifierProvider(
          create: (context) => WishListController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchControll(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddAddressController(),
        ),
        ChangeNotifierProvider(
          create: (context) => PaymentController(),
        )
      ],
      child: OverlaySupport.global(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.grey,
              appBarTheme: const AppBarTheme(
                color: Colors.orange,
              )),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}

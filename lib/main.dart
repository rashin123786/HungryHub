import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hungryhub/controlls/check_out_controller.dart';
import 'package:hungryhub/controlls/wish_list_controller.dart';
import 'package:hungryhub/view/SplashScreen/splash_screen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'controlls/authentication.dart';
import 'controlls/bottom_nav_controler.dart';
import 'controlls/cart_list_controller.dart';

import 'controlls/payment_controller.dart';
import 'controlls/search_controller.dart';
import 'controlls/add_address.dart';

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

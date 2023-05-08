import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hungryhub/controller/provider/authentication.dart';

import 'package:hungryhub/view/cart/cart.dart';

import 'package:hungryhub/view/checkout/Address/delivary_details.dart';

import 'package:hungryhub/view/settings/settings_screen.dart';

import 'package:hungryhub/view/wishlist/wish_list.dart';
import 'package:provider/provider.dart';

import '../../controller/constants/constants.dart';

bool isAddress = false;

class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final authenticaProvider = Provider.of<AuthenticateProvider>(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Drawer(
      width: width * 0.6,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.photoURL ??
                    'https://toppng.com/uploads/preview/customer-icon-whatsapp-profile-picture-ico-115630569778argolzwmt.png'),
              ),
              sizedboxHeight10,
              sizedboxHeight20,
              ListTile(
                title: Text('WishList', style: menuscreen20),
                textColor: backgroundcolor,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WishListScreen(),
                      ));
                },
              ),
              ListTile(
                title: Text(
                  'Cart',
                  style: menuscreen20,
                ),
                textColor: backgroundcolor,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ));
                },
              ),
              ListTile(
                title: Text(
                  'Address Book',
                  style: menuscreen20,
                ),
                textColor: backgroundcolor,
                onTap: () {
                  isAddress = true;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddressDetails(),
                      ));
                },
              ),
              ListTile(
                title: Text(
                  'Settings',
                  style: menuscreen20,
                ),
                textColor: backgroundcolor,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingScreen(),
                      ));
                },
              ),
              sizedboxHeight50,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundcolor,
                ),
                onPressed: () async {
                  authenticaProvider.logOut(context);
                  // authenticaProvider.logOutWithGoogle(context);
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              sizedboxHeight50,
              sizedboxHeight50,
              const Text('V 1.0')
            ],
          ),
        ),
      ),
    );
  }
}

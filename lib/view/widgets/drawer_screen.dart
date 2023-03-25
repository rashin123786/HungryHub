import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hungryhub/domain/services/offer.dart';
import 'package:hungryhub/view/productOverview/product_overview.dart';
import 'package:provider/provider.dart';

import '../../controlls/authentication.dart';
import '../../domain/constants/constants.dart';

class DrawerScreen extends StatelessWidget {
  DrawerScreen({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final authpProvider =
        Provider.of<AuthenticateProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
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
              Text(
                user.displayName ?? 'user1',
                style: GoogleFonts.secularOne(
                  fontSize: 25,
                ),
              ),
              sizedboxHeight20,
              ListTile(
                textColor: backgroundcolor,
                onTap: () {},
                title: Text(
                  'My Profile',
                  style: GoogleFonts.secularOne(
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'WishList',
                  style: GoogleFonts.secularOne(
                    fontSize: 20,
                  ),
                ),
                textColor: backgroundcolor,
              ),
              ListTile(
                title: Text(
                  'Cart',
                  style: GoogleFonts.secularOne(
                    fontSize: 20,
                  ),
                ),
                textColor: backgroundcolor,
              ),
              ListTile(
                title: Text(
                  'Settings',
                  style: GoogleFonts.secularOne(
                    fontSize: 20,
                  ),
                ),
                textColor: backgroundcolor,
              ),
              sizedboxHeight50,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundcolor,
                ),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductOverView(),
                      ));
                  // fetchOfferDetails();
                  //  hlo();
                  //  authpProvider.logOutWithGoogle(context);
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

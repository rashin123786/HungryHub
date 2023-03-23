import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hungryhub/domain/constants/constants.dart';
import 'package:provider/provider.dart';

import '../../controlls/authentication.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final user = FirebaseAuth.instance.currentUser!;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final authpProvider =
        Provider.of<GoogleSignInProvider>(context, listen: false);
    return Scaffold(
      key: scaffoldKey,
      endDrawer: Drawer(
        width: width * 0.6,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user.photoURL ??
                      'https://toppng.com/uploads/preview/customer-icon-whatsapp-profile-picture-ico-115630569778argolzwmt.png'),
                ),
                Text(
                  user.displayName ?? 'User',
                ),
                ListTile(
                  textColor: backgroundcolor,
                  onTap: () {},
                  title: const Text(
                    'My Profile',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'WishList',
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  textColor: backgroundcolor,
                ),
                ListTile(
                  title: const Text(
                    'Cart',
                  ),
                  textColor: backgroundcolor,
                ),
                ListTile(
                  title: const Text(
                    'Settings',
                  ),
                  textColor: backgroundcolor,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delightful delivery,\nwherever you are.',
                    style: GoogleFonts.secularOne(
                      fontSize: 25,
                    ),
                    // style: TextStyle(
                    //   fontSize: 25,
                    //   fontWeight: FontWeight.w900,
                    //   color: Color.fromARGB(255, 0, 0, 0),
                    // ),
                  ),
                  IconButton(
                    onPressed: () {
                      scaffoldKey.currentState!.openEndDrawer();
                    },
                    icon: const Icon(
                      Icons.list,
                      size: 30,
                    ),
                  )
                ],
              ),
              sizedboxHeight20,
              CarouselSlider.builder(
                itemBuilder: (context, index, realIndex) {
                  final imagesoffer = images[index];
                  return Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Container(
                        width: width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(
                                imagesoffer,
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        left: width * 0.08,
                        top: height * 0.1,
                        child: const Text(
                          '30% Off',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.amberAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  );
                },
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                itemCount: images.length,
              ),
              sizedboxHeight20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(255, 199, 0, 1),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'Burgers',
                      style: GoogleFonts.secularOne(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(255, 199, 0, 1),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      '  Pizza  ',
                      style: GoogleFonts.secularOne(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(255, 199, 0, 1),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'SandWich',
                      style: GoogleFonts.secularOne(),
                    ),
                  ),
                ],
              ),
              TextButton(
                  onPressed: () {
                    authpProvider.logOutWithGoogle(context);
                  },
                  child: const Text('jk')),
              const Center(
                child: Text(
                  'Recommended Food',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              sizedboxHeight10,
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: (1 / 0.7),
                    crossAxisSpacing: 2,
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final imagses = images[index];
                  return Card(
                    child: Container(
                      width: width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(
                              imagses,
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                  );
                },
                itemCount: images.length,
              )
            ],
          ),
        ),
      )),
    );
  }
}

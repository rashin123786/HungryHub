import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:hungryhub/UI/authentication/view/sign_in.dart';
import 'package:hungryhub/domain/constants/constants.dart';
import 'package:provider/provider.dart';

import '../../controlls/authentication.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    print('sfjo');
    final authpProvider =
        Provider.of<GoogleSignInProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Relax, think of food\nand here it is.',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
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
                      child: Text(
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
            TextButton(
                onPressed: () {
                  authpProvider.logOut(context);
                },
                child: Text('jk')),
          ],
        ),
      )),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hungryhub/controller/constants/constants.dart';

import 'package:hungryhub/view/Home/widgets/offer_card_widget.dart';
import 'package:hungryhub/view/category/Burger/burger_screen.dart';
import 'package:hungryhub/view/category/pizza/pizza_screen.dart';
import 'package:hungryhub/view/category/sandwich/sandwich_screen.dart';

import 'package:hungryhub/view/Home/widgets/popular_food.dart';
import 'package:hungryhub/view/menu/menu_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final CollectionReference offerfoods =
      FirebaseFirestore.instance.collection('offers');
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 30, right: 10),
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
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuScreen(),
                          ));
                    },
                    icon: const Icon(
                      Icons.list,
                      size: 30,
                    ),
                  )
                ],
              ),
              sizedboxHeight20,
              OfferCardWidget(width: width, height: height),
              sizedboxHeight20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      isCategory = 1;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BurgerScreen(),
                        ),
                      );
                    },
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
                    onPressed: () {
                      isCategory = 2;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PizzaScreen(),
                        ),
                      );
                    },
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
                    onPressed: () {
                      isCategory = 3;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SandwichScreen(),
                        ),
                      );
                    },
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
              sizedboxHeight20,
              const Center(
                child: Text(
                  'Popular Food',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              sizedboxHeight10,
              const PopularFoods(),
            ],
          ),
        ),
      )),
    );
  }
}

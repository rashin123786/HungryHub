import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hungryhub/domain/constants/constants.dart';
import 'package:hungryhub/domain/services/offer.dart';
import 'package:hungryhub/model/offermodel.dart';
import 'package:hungryhub/view/productOverview/product_overview.dart';
import 'package:hungryhub/view/widgets/drawer_screen.dart';

OfferModel? datass;

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
      endDrawer: DrawerScreen(),
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
              StreamBuilder(
                stream: getUserStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CarouselSlider.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index, realIndex) {
                        final data = snapshot.data![index];
                        return Stack(
                          fit: StackFit.loose,
                          children: [
                            GestureDetector(
                              child: Container(
                                width: width * 0.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        data.productImage,
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              onTap: () async {
                                datass = OfferModel(
                                  productImage: data.productImage,
                                  productName: data.productName,
                                  productRate: data.productRate,
                                  productRating: data.productRating,
                                  productTime: data.productTime,
                                );
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ProductOverView(),
                                    ));
                              },
                            ),
                            Positioned(
                              left: width * 0.001,
                              top: height * 0.10,
                              child: CircleAvatar(
                                backgroundColor: backgroundcolor,
                                radius: 37,
                                child: const Center(
                                  child: Text(
                                    '  30%\n  Off',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                      options: CarouselOptions(
                        height: height * 0.2,
                        autoPlay: true,
                        enlargeCenterPage: true,
                      ),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Text('Something Wrong');
                  }
                },
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
              sizedboxHeight20,
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

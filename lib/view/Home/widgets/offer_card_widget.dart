import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hungryhub/model/all_product_model.dart.dart';

import '../../../domain/constants/constants.dart';
import '../../../domain/services/offer.dart';

import '../../productOverview/product_overview.dart';

class OfferCardWidget extends StatelessWidget {
  const OfferCardWidget({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getOfferStream(),
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
                      isOffer = false;
                      allDatas = AllProductDetails(
                        id: data.id,
                        productImage: data.productImage,
                        productName: data.productName,
                        productRate: data.productRate,
                        productDescription: data.productDescription,
                        productTime: data.productTime,
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProductOverView(),
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
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          print(snapshot.error.toString());
          return const Text('Something Wrong');
        }
      },
    );
  }
}

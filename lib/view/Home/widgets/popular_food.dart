import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungryhub/controlls/offer.dart';
import 'package:hungryhub/domain/constants/constants.dart';
import 'package:hungryhub/domain/services/popular_food.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/all_product_model.dart.dart';
import '../../productOverview/product_overview.dart';

class PopularFoods extends StatelessWidget {
  PopularFoods({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return StreamBuilder(
      stream: getPopularStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: (0.53 / 0.7),
                crossAxisSpacing: 2,
                crossAxisCount: 2),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final popularData = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () async {
                    isOffer = true;
                    allDatas = await AllProductDetails(
                      productImage: popularData.productImage,
                      productName: popularData.productName,
                      productRate: popularData.productRate,
                      productDescription: popularData.productDescription,
                      productTime: popularData.productTime,
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductOverView(),
                        ));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white,
                    shadowColor: backgroundcolor,
                    elevation: 15,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                popularData.productImage,
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: height * 0.2,
                              ),
                            ),
                            Positioned(
                              left: width * 0.35,
                              top: height * 0.15,
                              child: CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                    onPressed: () {
                                      // Provider.of<WishListData>(context,
                                      //         listen: false)
                                      //     .addWishListData();
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color: Colors.amber,
                                      size: 35,
                                    )),
                              ),
                            )
                          ],
                        ),
                        Flexible(
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              style: GoogleFonts.secularOne(
                                  fontSize: 20, color: Colors.black),
                              text: "  ${popularData.productName}",
                            ),
                          ),
                        ),
                        Text(
                          "₹${popularData.productRate}",
                          style: GoogleFonts.secularOne(
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Text('Something went wrong');
        }
      },
    );
  }
}

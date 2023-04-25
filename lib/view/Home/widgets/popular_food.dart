import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:hungryhub/controller/constants/constants.dart';
import 'package:hungryhub/controller/services/popular_food.dart';
import 'package:hungryhub/view/widgets/wish_list_button.dart';

import '../../../model/all_product_model.dart.dart';
import '../../productOverview/product_overview.dart';

class PopularFoods extends StatelessWidget {
  const PopularFoods({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                childAspectRatio: (0.4 / 0.57),
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
                    allDatas = AllProductDetails(
                      id: popularData.id,
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
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    color: Colors.white,
                    shadowColor: backgroundcolor,
                    elevation: 15,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(22.0),
                              child: Image.network(
                                popularData.productImage,
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: height * 0.2,
                              ),
                            ),
                            WishListButton(
                              id: popularData.id,
                              productDescription:
                                  popularData.productDescription,
                              productImage: popularData.productImage,
                              productName: popularData.productName,
                              productRate: popularData.productRate,
                              productTime: popularData.productTime,
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

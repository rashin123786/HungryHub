// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hungryhub/view/productOverview/product_overview.dart';

import '../../domain/constants/constants.dart';
import '../../model/all_product_model.dart.dart';
import '../widgets/wish_list_button.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({super.key, required this.searchStream});
  Stream<List<AllProductDetails>>? searchStream;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final height = size.height;

    return StreamBuilder(
      stream: searchStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: (0.45 / 0.55),
                crossAxisCount: 2,
                crossAxisSpacing: 2,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final datare = snapshot.data![index];

                return GestureDetector(
                  onTap: () {
                    allDatas = AllProductDetails(
                        id: datare.id,
                        productImage: datare.productImage,
                        productName: datare.productName,
                        productRate: datare.productRate,
                        productDescription: datare.productDescription,
                        productTime: datare.productTime);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductOverView(),
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
                                borderRadius: BorderRadius.circular(21.0),
                                child: Image.network(
                                  datare.productImage,
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: height * 0.2,
                                ),
                              ),
                              WishListButton(
                                id: datare.id,
                                productImage: datare.productImage,
                                productName: datare.productName,
                                productRate: datare.productRate,
                                productDescription: datare.productDescription,
                                productTime: datare.productTime,
                              ),
                            ],
                          ),
                          Flexible(
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                style: GoogleFonts.secularOne(
                                    fontSize: 20, color: Colors.black),
                                text: "  ${datare.productName}",
                              ),
                            ),
                          ),
                          Text(
                            "₹${datare.productRate}",
                            style: GoogleFonts.secularOne(
                              fontSize: 25,
                            ),
                          ),
                        ],
                      )),
                );
              },
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return const Text('no found');
        }
      },
    );
  }
}

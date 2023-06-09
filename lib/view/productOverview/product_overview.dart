import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungryhub/controller/constants/constants.dart';
import 'package:hungryhub/model/all_product_model.dart.dart';
import 'package:hungryhub/view/cart/cart.dart';
import 'package:hungryhub/view/checkout/Address/delivary_details.dart';
import 'package:hungryhub/view/menu/menu_screen.dart';

import 'package:hungryhub/view/widgets/counter.dart';

import '../widgets/wish_list_button.dart';
import 'widgets/amount_detials.dart';

class ProductOverView extends StatelessWidget {
  const ProductOverView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final width = size.width;
    final height = size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(19),
                        child: Image.network(
                          allDatas.productImage,
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                      WishListButton(
                        id: allDatas.id,
                        productImage: allDatas.productImage,
                        productName: allDatas.productName,
                        productRate: allDatas.productRate,
                        productDescription: allDatas.productDescription,
                        productTime: allDatas.productTime,
                      )
                    ],
                  ),
                ),
                sizedboxHeight10,
                Text(
                  allDatas.productName,
                  style: GoogleFonts.secularOne(
                    fontSize: 28,
                    color: backgroundcolor,
                  ),
                ),
                sizedboxHeight20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      " ⏰${allDatas.productTime} ",
                      style: GoogleFonts.secularOne(
                        fontSize: 20,
                      ),
                    ),
                    CounterWidget(
                      id: allDatas.id,
                      productDescription: allDatas.productDescription,
                      productImage: allDatas.productImage,
                      productName: allDatas.productName,
                      productRate: allDatas.productRate,
                      productTime: allDatas.productTime,
                      produtQuantity: 1,
                    ),
                    !isOffer
                        ? Flexible(
                            child: RichText(
                              text: TextSpan(
                                  text: '30% off \n',
                                  style: GoogleFonts.secularOne(
                                      fontSize: 15, color: Colors.amber),
                                  children: [
                                    TextSpan(children: [
                                      TextSpan(
                                          text: "₹${allDatas.productRate}",
                                          style: GoogleFonts.secularOne(
                                            fontSize: 20,
                                            color: Colors.black,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ))
                                    ])
                                  ]),
                            ),
                          )
                        : Text(
                            "₹${allDatas.productRate}",
                            style: GoogleFonts.secularOne(
                              fontSize: 20,
                            ),
                          )
                  ],
                ),
                sizedboxHeight10,
                Text(
                  allDatas.productDescription,
                  style: GoogleFonts.secularOne(
                    fontSize: 15,
                    color: const Color.fromARGB(255, 161, 161, 161),
                  ),
                ),
                divider,
                !isOffer
                    ? ProductOverViewAmount(
                        leftText: 'Subtotal',
                        rightText:
                            "₹${((allDatas.productRate / 100) * 30).floorToDouble()}",
                      )
                    : ProductOverViewAmount(
                        leftText: 'Subtotal',
                        rightText: "₹${allDatas.productRate}",
                      ),
                const ProductOverViewAmount(
                  leftText: 'Additional Fee',
                  rightText: "₹${10}",
                ),
                divider,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: GoogleFonts.secularOne(
                        fontSize: 25,
                      ),
                    ),
                    !isOffer
                        ? Text(
                            "₹${((allDatas.productRate / 100) * 30).floorToDouble() + 10}",
                            softWrap: true,
                            style: GoogleFonts.secularOne(
                              fontSize: 20,
                            ),
                          )
                        : Text(
                            "₹${allDatas.productRate + 10}",
                            softWrap: true,
                            style: GoogleFonts.secularOne(
                              fontSize: 20,
                            ),
                          )
                  ],
                ),
                divider,
                !isOffer
                    ? SizedBox(
                        height: height * 0.08,
                      )
                    : SizedBox(
                        height: height * 0.139,
                      ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundcolor,
            minimumSize: const Size.fromHeight(45)),
        onPressed: () {
          isAddress = false;
          if (isOffer == false) {
            allDatas = AllProductDetails(
                productImage: allDatas.productImage,
                productName: allDatas.productName,
                productRate: allDatas.productRate,
                productDescription: allDatas.productDescription,
                productTime: allDatas.productTime);
          } else if (isOffer == true) {
            allDatas = AllProductDetails(
                productImage: allDatas.productImage,
                productName: allDatas.productName,
                productRate: allDatas.productRate,
                productDescription: allDatas.productDescription,
                productTime: allDatas.productTime);
          }
          carrtInt = 2;
          isCart = false;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddressDetails(),
              ));
        },
        child: Text(
          'Buy',
          style: GoogleFonts.secularOne(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

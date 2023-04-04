import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungryhub/controlls/wish_list_controller.dart';
import 'package:hungryhub/view/Home/widgets/wish_list_button.dart';
import 'package:provider/provider.dart';

import '../../domain/constants/constants.dart';
import '../../model/all_product_model.dart.dart';
import '../productOverview/product_overview.dart';

class WishListScreen extends StatefulWidget {
  WishListScreen({
    super.key,
    this.id,
    this.productDescription,
    this.productImage,
    this.productName,
    this.productRate,
    this.productTime,
  });
  String? id;
  String? productImage;
  String? productName;
  int? productRate;
  String? productDescription;
  String? productTime;
  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final wishListController = Provider.of<WishListController>(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      wishListController.getWishList();
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'WishList',
          style: GoogleFonts.secularOne(fontSize: 30, color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: wishListController.AllwishListData.isEmpty
            ? Center(
                child: Text('No Data Found'),
              )
            : GridView.builder(
                itemCount: wishListController.AllwishListData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: (0.55 / 0.67),
                    crossAxisSpacing: 2,
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final data = wishListController.AllwishListData[index];
                  return GestureDetector(
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
                                  data.productImage,
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: height * 0.2,
                                ),
                              ),
                              WishListButton(
                                id: data.id,
                                productDescription: data.productDescription,
                                productName: data.productName,
                                productImage: data.productImage,
                                productRate: data.productRate,
                                productTime: data.productTime,
                              )
                            ],
                          ),
                          Flexible(
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                style: GoogleFonts.secularOne(
                                    fontSize: 20, color: Colors.black),
                                text: data.productName,
                              ),
                            ),
                          ),
                          Text(
                            "${data.productRate}",
                            style: GoogleFonts.secularOne(
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () async {
                      allDatas = await AllProductDetails(
                          id: data.id,
                          productImage: data.productImage,
                          productName: data.productName,
                          productRate: data.productRate,
                          productDescription: data.productDescription,
                          productTime: data.productTime);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProductOverView(),
                          ));
                    },
                  );
                },
              ),
      )),
    );
  }
}

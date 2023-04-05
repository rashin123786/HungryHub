// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hungryhub/controlls/wish_list_controller.dart';

import 'package:provider/provider.dart';
import 'package:overlay_support/overlay_support.dart';

class WishListButton extends StatefulWidget {
  WishListButton({
    super.key,
    this.id,
    this.productDescription,
    this.productImage,
    this.productName,
    this.productRate,
    this.productTime,
    this.icon,
    this.ontap,
    this.wishList,
  });
  Function()? ontap;
  IconData? icon;
  String? id;
  String? productImage;
  String? productName;
  int? productRate;
  String? productDescription;
  String? productTime;
  bool? wishList = false;

  @override
  State<WishListButton> createState() => _WishListButtonState();
}

class _WishListButtonState extends State<WishListButton> {
  bool isWish = false;
  getWishListBool() {
    FirebaseFirestore.instance
        .collection('wishlist')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('yourwishlist')
        .doc(widget.id)
        .get()
        .then((value) {
      if (mounted) {
        if (value.exists) {
          setState(() {
            isWish = value.get('wishList');
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getWishListBool();
    final wishListController = Provider.of<WishListController>(context);

    return Align(
      alignment: Alignment.topRight,
      child: CircleAvatar(
          radius: 22,
          backgroundColor: Colors.white,
          child: isWish == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isWish = false;
                    });
                    wishListController.wishListDelete(widget.id);
                    showSimpleNotification(
                        Text(
                          'Removed from WishList',
                          style: GoogleFonts.secularOne(
                              fontSize: 20, color: Colors.amber),
                        ),
                        background: Colors.white,
                        duration: const Duration(milliseconds: 300));
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.amber,
                    size: 30,
                  ))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isWish == true;
                    });
                    wishListController.addToWishList(
                      id: widget.id,
                      productDescription: widget.productDescription,
                      productImage: widget.productImage,
                      productName: widget.productName,
                      productRate: widget.productRate,
                      productTime: widget.productTime,
                    );
                    showSimpleNotification(
                        Text(
                          'Added To WishList',
                          style: GoogleFonts.secularOne(
                              fontSize: 20, color: Colors.amber),
                        ),
                        background: Colors.white,
                        duration: const Duration(milliseconds: 300));
                  },
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Colors.amber,
                  ))),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:provider/provider.dart';

import '../../controller/provider/cart_list_controller.dart';

// ignore: must_be_immutable
class CounterWidget extends StatefulWidget {
  CounterWidget({
    super.key,
    this.id,
    this.productDescription,
    this.productImage,
    this.productName,
    this.productRate,
    this.productTime,
    this.produtQuantity,
  });
  String? id;
  String? productImage;
  String? productName;
  int? productRate;
  String? productDescription;
  String? productTime;
  int? produtQuantity;
  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int count = 1;
  bool isTrue = false;
  getAddAndQuantity() {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('yourcart')
        .doc(widget.id)
        .get()
        .then((value) => {
              if (mounted)
                {
                  if (value.exists)
                    {
                      setState(() {
                        count = value.get('produtQuantity');
                        isTrue = value.get("isAdd");
                      })
                    }
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    getAddAndQuantity();
    final cartProductControll =
        Provider.of<CartProductControll>(context, listen: false);

    return Container(
      width: 120,
      height: 30,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.amber),
          borderRadius: BorderRadius.circular(10)),
      child: isTrue == true
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    if (count == 1) {
                      setState(() {
                        isTrue = false;
                      });

                      cartProductControll.cartDeleteData(widget.id);
                      showSimpleNotification(
                          Text(
                            ' item deleted from cart',
                            style: GoogleFonts.secularOne(
                                fontSize: 20, color: Colors.amber),
                          ),
                          background: Colors.white,
                          duration: const Duration(milliseconds: 300));
                    } else {
                      setState(() {
                        count--;
                      });
                      cartProductControll.updatedCartData(
                        id: widget.id,
                        productDescription: widget.productDescription ?? '',
                        productImage: widget.productImage ?? '',
                        productName: widget.productName ?? '',
                        productRate: widget.productRate,
                        productTime: widget.productTime ?? '',
                        produtQuantity: count,
                      );
                      showSimpleNotification(
                          Text(
                            '1 item removed from cart',
                            style: GoogleFonts.secularOne(
                                fontSize: 20, color: Colors.amber),
                          ),
                          background: Colors.white,
                          duration: const Duration(milliseconds: 300));
                    }
                  },
                  child: const Icon(
                    Icons.remove,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '$count',
                  style: GoogleFonts.secularOne(
                    fontSize: 20,
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (count >= 6) {
                      showSimpleNotification(
                          Text(
                            'you reached your minimum quantity',
                            style: GoogleFonts.secularOne(
                                fontSize: 20, color: Colors.amber),
                          ),
                          background: Colors.white,
                          duration: const Duration(milliseconds: 300));
                    } else {
                      setState(() {
                        count++;
                      });
                      cartProductControll.updatedCartData(
                        id: widget.id,
                        productDescription: widget.productDescription ?? '',
                        productImage: widget.productImage ?? '',
                        productName: widget.productName ?? '',
                        productRate: widget.productRate,
                        productTime: widget.productTime ?? '',
                        produtQuantity: count,
                      );
                      showSimpleNotification(
                          Text(
                            '1 item added to cart',
                            style: GoogleFonts.secularOne(
                                fontSize: 20, color: Colors.amber),
                          ),
                          background: Colors.white,
                          duration: const Duration(milliseconds: 300));
                    }
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 20,
                  ),
                )
              ],
            )
          : InkWell(
              onTap: () {
                setState(() {
                  isTrue = true;
                });
                cartProductControll.addCartData(
                  id: widget.id,
                  productDescription: widget.productDescription ?? '',
                  productImage: widget.productImage ?? '',
                  productName: widget.productName ?? '',
                  productRate: widget.productRate,
                  productTime: widget.productTime ?? '',
                  produtQuantity: count,
                );
              },
              child: Center(
                child: Text(
                  'Add To Cart',
                  style:
                      GoogleFonts.secularOne(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
    );
  }
}

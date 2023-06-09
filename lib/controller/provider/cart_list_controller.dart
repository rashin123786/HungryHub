import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hungryhub/model/cart_model.dart.dart';
import 'package:overlay_support/overlay_support.dart';

String cartid = '';

class CartProductControll with ChangeNotifier {
  int count = 1;
  bool isTrue = false;
///////////////   Add to Cart   //////////////////////////
  void addCartData({
    String? id,
    String productImage = '',
    String? productName = '',
    int? productRate,
    String? productDescription = '',
    String? productTime = '',
    int? produtQuantity,
  }) async {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('yourcart')
        .doc(id)
        .set({
      "productImg": productImage,
      "productId": id,
      "productName": productName,
      "productRate": productRate,
      "productDescription": productDescription,
      "productTime": productTime,
      "produtQuantity": produtQuantity,
      "isAdd": true,
    }).then((value) {
      showSimpleNotification(
          Text(
            'Add to cart',
            style: GoogleFonts.secularOne(fontSize: 20, color: Colors.amber),
          ),
          background: Colors.white,
          duration: const Duration(milliseconds: 300));
    });
    notifyListeners();
  }

//////////////   Update Cart   //////////////////////

  void updatedCartData({
    String? id,
    String productImage = '',
    String? productName = '',
    int? productRate,
    String? productDescription = '',
    String? productTime = '',
    int? produtQuantity,
  }) async {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('yourcart')
        .doc(id)
        .update({
      "productImg": productImage,
      "productId": id,
      "productName": productName,
      "productRate": productRate,
      "productDescription": productDescription,
      "productTime": productTime,
      "produtQuantity": produtQuantity,
      "isAdd": true,
    });
    notifyListeners();
  }

///////////////   Get Cart Data    ////////////////////////////

  List<CartModel> cartDataList = [];
  void getCartList() async {
    List<CartModel> newList = [];
    final cartValue = await FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('yourcart')
        .get();
    for (var element in cartValue.docs) {
      CartModel cartModel = CartModel(
        id: element.get('productId'),
        productImage: element.get('productImg'),
        productName: element.get('productName'),
        productRate: element.get('productRate'),
        productDescription: element.get('productDescription'),
        productTime: element.get('productTime'),
        produtQuantity: element.get('produtQuantity'),
      );
      newList.add(cartModel);
    }
    cartDataList = newList;
    notifyListeners();
  }

  List<CartModel> get getcartDataList {
    return cartDataList;
  }

  ////////////   cart Delete    /////////////////////
  cartDeleteData(productId) {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('yourcart')
        .doc(productId)
        .delete();
    notifyListeners();
  }

  getTotalPrice() {
    num total = 0.0;
    for (var element in cartDataList) {
      total += element.productRate * element.produtQuantity!;
    }
    return total;
  }
}

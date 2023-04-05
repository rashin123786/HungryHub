import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:hungryhub/model/cart_model.dart.dart';

class CartProductControll with ChangeNotifier {
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
    cartValue.docs.forEach((element) {
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
    });
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
    cartDataList.forEach((element) {
      total += element.productRate * element.produtQuantity!;
    });
    return total;
  }
}

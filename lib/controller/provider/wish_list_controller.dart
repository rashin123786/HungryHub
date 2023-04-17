import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/all_product_model.dart.dart';

class WishListController with ChangeNotifier {
  bool isLoding = false;
  void addToWishList({
    String? id,
    String? productName,
    String? productImage,
    int? productRate,
    String? productTime,
    String? productDescription,
  }) async {
    FirebaseFirestore.instance
        .collection('wishlist')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('yourwishlist')
        .doc(id)
        .set({
      "productImg": productImage,
      "productId": id,
      "productName": productName,
      "productRate": productRate,
      "productDescription": productDescription,
      "productTime": productTime,
      "wishList": true,
    });
    notifyListeners();
  }

  List<AllProductDetails> wishlistData = [];
  void getWishList() async {
    List<AllProductDetails> newwishlist = [];

    final wishListValue = await FirebaseFirestore.instance
        .collection('wishlist')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('yourwishlist')
        .get();
    for (var element in wishListValue.docs) {
      AllProductDetails allProductDetails = AllProductDetails(
        id: element.get('productId'),
        productImage: element.get('productImg'),
        productName: element.get('productName'),
        productRate: element.get('productRate'),
        productDescription: element.get('productDescription'),
        productTime: element.get('productTime'),
      );
      newwishlist.add(allProductDetails);
    }

    wishlistData = newwishlist;
    notifyListeners();
  }

  List<AllProductDetails> get allwishListData {
    return wishlistData;
  }

///////// WishList Delete  ////////////////////

  wishListDelete(productId) {
    FirebaseFirestore.instance
        .collection('wishlist')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('yourwishlist')
        .doc(productId)
        .delete();
    notifyListeners();
  }

  void add() {
    FirebaseFirestore.instance
        .collection('something')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('newcollection')
        .add({
      "name": "rashin",
      "age": 19,
    });
  }
}

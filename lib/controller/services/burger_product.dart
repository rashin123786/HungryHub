import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/all_product_model.dart.dart';

final CollectionReference burgerCollect =
    FirebaseFirestore.instance.collection('burgers');
//////////       Get Burger List     ///////////////////////

Stream<List<AllProductDetails>> getBurgerStream() {
  return burgerCollect.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      return AllProductDetails.fromjson(doc.data() as Map<String, dynamic>);
    }).toList();
  });
}

//////////       search Burger List     ///////////////////////
///
Stream<List<AllProductDetails>> searchBurger(String searchQuery) {
  return burgerCollect.snapshots().map((snapshot) {
    return snapshot.docs
        .map((doc) =>
            AllProductDetails.fromjson(doc.data() as Map<String, dynamic>))
        .where((product) => product.productName
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();
  });
}

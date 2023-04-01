import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/all_product_model.dart.dart';

final CollectionReference burgerCollect =
    FirebaseFirestore.instance.collection('burgers');

Stream<List<AllProductDetails>> getBurgerStream() {
  return burgerCollect.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      return AllProductDetails.fromjson(doc.data() as Map<String, dynamic>);
    }).toList();
  });
}

Stream<List<AllProductDetails>> getBurgerSearch(String query) {
  return burgerCollect
      .where('productName', isEqualTo: query)
      .snapshots()
      .map((event) {
    return event.docs.map((e) {
      return AllProductDetails.fromjson(e.data() as Map<String, dynamic>);
    }).toList();
  });
}

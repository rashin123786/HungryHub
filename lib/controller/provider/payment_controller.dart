import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hungryhub/controller/constants/constants.dart';
import 'package:hungryhub/model/all_product_model.dart.dart';
import 'package:hungryhub/model/cart_model.dart.dart';
import 'package:intl/intl.dart';

import '../../view/cart/cart.dart';

enum PaymentType {
  cod,
  onlinepayment,
}

class PaymentController with ChangeNotifier {
  PaymentType myType = PaymentType.cod;
  PaymentType get myPay => myType;

  void checkPymentMethod(PaymentType value) {
    myType = value;
    notifyListeners();
  }

  void addOrderHistory(String response, List<CartModel> items) async {
    DateTime datetime = DateTime.now();
    String formatDate = DateFormat('dd-MMMM-yyyy HH:mm').format(datetime);
    List<String> productName = [];
    List<int> productquantity = [];
    List<int> productrate = [];
    for (var element in items) {
      productName.add(element.productName);
      productrate.add(element.productRate);
      productquantity.add(element.produtQuantity ?? 1);
    }
    await FirebaseFirestore.instance
        .collection("orderhistory")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("yourorder")
        .doc()
        .set({
      "paymentId": response,
      "dateTime": formatDate,
      "amount": isCart == true ? amount : allDatas.productRate + 50,
      "productName": productName,
      "productRate": productrate,
      "productquantity": productquantity,
    }).then((value) {
      productName.clear();
      productrate.clear();
      productquantity.clear();
    });
  }

  void deletecart() async {
    final querysnap = await FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('yourcart')
        .get();
    for (var element in querysnap.docs) {
      element.reference.delete();
    }
  }
}

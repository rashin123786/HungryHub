import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungryhub/model/address_model.dart';
import 'package:hungryhub/view/checkout/Address/add_delivary_address.dart';
import 'package:overlay_support/overlay_support.dart';

class CheckOutController with ChangeNotifier {
  // addAddress(context) async {
  //   await FirebaseFirestore.instance
  //       .collection('addAddress')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .set({
  //     'fullname': fullNamecontroller.text,
  //     'mobilenumber': numbercontroller.text,
  //     'street': streetcontroller.text,
  //     'landmark': landMarkControler.text,
  //     'city': cityControler.text,
  //     'pincode': pincodeControler.text,
  //   });
  //   notifyListeners();
  // }

  // void clearText() {
  //   numbercontroller.clear();
  //   fullNamecontroller.clear();
  //   streetcontroller.clear();
  //   cityControler.clear();
  //   landMarkControler.clear();
  //   locationControler.clear();
  //   pincodeControler.clear();
  //   notifyListeners();
  // }

  List<DelivaryAddressModel> allDelivaryDetails = [];
  getAddress() async {
    List<DelivaryAddressModel> newDelivaryDetails = [];
    DelivaryAddressModel? delivaryAddressModel;
    final value = await FirebaseFirestore.instance
        .collection('addAddress')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (value.exists) {
      delivaryAddressModel = DelivaryAddressModel(
        city: value.get('city'),
        fullname: value.get('fullname'),
        landMark: value.get('landmark'),
        number: value.get('mobilenumber'),
        pincode: value.get('pincode'),
        street: value.get('street'),
      );
      newDelivaryDetails.add(delivaryAddressModel);
      notifyListeners();
    } else {
      return Text('No data foundss');
    }
    allDelivaryDetails = newDelivaryDetails;
    notifyListeners();
  }

  List<DelivaryAddressModel> get delivaryAddressListResult {
    return allDelivaryDetails;
  }

  deleteAddress() {
    FirebaseFirestore.instance
        .collection('addAddress')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete();
    notifyListeners();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:hungryhub/model/address_model.dart';

class CheckOutController with ChangeNotifier {
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
      return const Text('No data foundss');
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

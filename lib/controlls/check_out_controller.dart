import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungryhub/model/address_model.dart';
import 'package:overlay_support/overlay_support.dart';

class CheckOutController with ChangeNotifier {
  final fullNamecontroller = TextEditingController();
  final numbercontroller = TextEditingController();
  final streetcontroller = TextEditingController();
  final landMarkControler = TextEditingController();
  final cityControler = TextEditingController();
  final pincodeControler = TextEditingController();
  final locationControler = TextEditingController();

  addAddress(context) async {
    await FirebaseFirestore.instance
        .collection('address')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'fullname': fullNamecontroller.text,
      'mobilenumber': numbercontroller.text,
      'street': streetcontroller.text,
      'landmark': landMarkControler.text,
      'city': cityControler.text,
      'pincode': pincodeControler.text,
      'location': locationControler.text,
    }).then((value) async {
      await showSimpleNotification(
          Text(
            'Addeed Address',
            style: GoogleFonts.secularOne(fontSize: 20, color: Colors.amber),
          ),
          background: Colors.white,
          duration: const Duration(milliseconds: 300));
      Navigator.pop(context);
      notifyListeners();
    });
    notifyListeners();
  }

  List<DelivaryAddressModel> allDelivaryDetails = [];
  getAddress() async {
    List<DelivaryAddressModel> newDelivaryDetails = [];
    DelivaryAddressModel? delivaryAddressModel;
    final value = await FirebaseFirestore.instance
        .collection('address')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (value.exists) {
      delivaryAddressModel = DelivaryAddressModel(
        City: value.get('city'),
        fullname: value.get('fullname'),
        landMark: value.get('landmark'),
        number: value.get('mobilenumber'),
        pincode: value.get('pincode'),
        street: value.get('street'),
      );
      newDelivaryDetails.add(delivaryAddressModel);
      notifyListeners();
    }
    allDelivaryDetails = newDelivaryDetails;
    notifyListeners();
  }

  List<DelivaryAddressModel> get delivaryAddressListResult {
    return allDelivaryDetails;
  }

  // deleteAddress() {
  //   FirebaseFirestore.instance
  //       .collection('addAddress')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .delete();
  //   notifyListeners();
  // }
}

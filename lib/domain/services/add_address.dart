import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hungryhub/model/address_model.dart';

final addressCollection = FirebaseFirestore.instance.collection("address");
final fullNamecontroller = TextEditingController();
final numbercontroller = TextEditingController();
final streetcontroller = TextEditingController();
final landMarkControler = TextEditingController();
final cityControler = TextEditingController();
final pincodeControler = TextEditingController();
final locationControler = TextEditingController();
void addAddress() {
  final result = addressCollection.add({
    "id": addressCollection.doc().id,
    "city": cityControler.text,
    "fullname": fullNamecontroller.text,
    "landmark": landMarkControler.text,
    "mobilenumber": numbercontroller.text,
    "pincode": pincodeControler.text,
    "street": streetcontroller.text,
  });
}

void clearText() {
  numbercontroller.clear();
  fullNamecontroller.clear();
  streetcontroller.clear();
  cityControler.clear();
  landMarkControler.clear();
  locationControler.clear();
  pincodeControler.clear();
}

Stream<List<DelivaryAddressModel>> getAddress() {
  return addressCollection.snapshots().map((event) {
    return event.docs.map((e) {
      return DelivaryAddressModel.fromjson(e.data() as Map<String, dynamic>);
    }).toList();
  });
}

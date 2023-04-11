import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:hungryhub/model/address_model.dart';

String? docId;

class AddAddressController with ChangeNotifier {
  final addressCollection = FirebaseFirestore.instance.collection("address");
  final fullNamecontroller = TextEditingController();
  final numbercontroller = TextEditingController();
  final streetcontroller = TextEditingController();
  final landMarkControler = TextEditingController();
  final cityControler = TextEditingController();
  final pincodeControler = TextEditingController();
  final locationControler = TextEditingController();
  void addAddress() {
    addressCollection.add({
      "id": addressCollection.id,
      "city": cityControler.text,
      "fullname": fullNamecontroller.text,
      "landmark": landMarkControler.text,
      "mobilenumber": numbercontroller.text,
      "pincode": pincodeControler.text,
      "street": streetcontroller.text,
    }).then((value) {
      docId = value.id;
      addressCollection.doc(docId).update({
        "id": docId,
      });
    });
    notifyListeners();
  }

  updateAddress(id) async {
    addressCollection.doc(id).update({
      "id": id,
      "city": cityControler.text,
      "fullname": fullNamecontroller.text,
      "landmark": landMarkControler.text,
      "mobilenumber": numbercontroller.text,
      "pincode": pincodeControler.text,
      "street": streetcontroller.text,
    }).then((value) {});
    notifyListeners();
  }

  void clearText() {
    numbercontroller.clear();
    fullNamecontroller.clear();
    streetcontroller.clear();
    cityControler.clear();
    landMarkControler.clear();
    locationControler.clear();
    pincodeControler.clear();
    notifyListeners();
  }

  List<DelivaryAddressModel> delivaryDetailsss = [];
  void getAllAddress() async {
    List<DelivaryAddressModel> newDelivaryDetailsss = [];
    final addresList = await addressCollection.get();
    for (var element in addresList.docs) {
      DelivaryAddressModel delivaryModel = DelivaryAddressModel(
          id: element.get('id'),
          city: element.get('city'),
          fullname: element.get('fullname'),
          landMark: element.get('landmark'),
          number: element.get('mobilenumber'),
          pincode: element.get('pincode'),
          street: element.get('street'));
      newDelivaryDetailsss.add(delivaryModel);
    }
    delivaryDetailsss = newDelivaryDetailsss;
    notifyListeners();
  }

  List<DelivaryAddressModel> get getResultAddressDetails {
    return delivaryDetailsss;
  }

  deleteAddress(id) {
    addressCollection.doc(id).delete();
    notifyListeners();
  }
}

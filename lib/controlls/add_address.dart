import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:hungryhub/model/address_model.dart';

import '../domain/constants/constants.dart';
import '../view/checkout/Address/google_map.dart';

String? docId;

class AddAddressController with ChangeNotifier {
  Set<Marker> markers = {};
  GoogleMapController? mapController;
  final addressCollection = FirebaseFirestore.instance.collection("address");
  final fullNamecontroller = TextEditingController();
  final numbercontroller = TextEditingController();
  final streetcontroller = TextEditingController();
  final landMarkControler = TextEditingController();
  final cityControler = TextEditingController();
  final pincodeControler = TextEditingController();
  final locationControler = TextEditingController();
  void addAddress() {
    addressCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("youraddress")
        .add({
      "id": addressCollection.id,
      "city": cityControler.text,
      "fullname": fullNamecontroller.text,
      "landmark": landMarkControler.text,
      "mobilenumber": numbercontroller.text,
      "pincode": pincodeControler.text,
      "street": streetcontroller.text,
    }).then((value) {
      print(value.id);
      docId = value.id;
      addressCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("youraddress")
          .doc(docId)
          .update({
        "id": docId,
      });
    });
    notifyListeners();
  }

  // addAddress1() {
  //   FirebaseFirestore.instance
  //       .collection("address")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection("youraddress")
  //       .doc()
  //       .set({
  //     "id": addressCollection.id,
  //     "city": cityControler.text,
  //     "fullname": fullNamecontroller.text,
  //     "landmark": landMarkControler.text,
  //     "mobilenumber": numbercontroller.text,
  //     "pincode": pincodeControler.text,
  //     "street": streetcontroller.text,
  //   });
  //   notifyListeners();
  // }

  void addGoogleMap({
    String? name,
    String? street,
    String? local,
    String? area,
    String? country,
    String? pincode,
  }) async {
    addressCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("youraddress")
        .add({
      "id": addressCollection.id,
      "city": area,
      "fullname": name,
      "landmark": local,
      "mobilenumber": country,
      "pincode": pincode,
      "street": street,
    }).then((value) {
      docId = value.id;
      addressCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("youraddress")
          .doc(docId)
          .update({
        "id": docId,
      });
    });
    notifyListeners();
  }

  updateAddress(id) async {
    addressCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("youraddress")
        .doc(id)
        .update({
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
  void getAllAddress1() async {
    List<DelivaryAddressModel> newDelivaryDetailsss = [];
    final addresList = await FirebaseFirestore.instance
        .collection("address")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("youraddress")
        .get();
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
    addressCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("youraddress")
        .doc(id)
        .delete();
    notifyListeners();
  }

  addLocationToFirebase() {
    addGoogleMap(
      area: allAddressData.city,
      country: allAddressData.number,
      local: allAddressData.landMark,
      name: allAddressData.fullname,
      pincode: allAddressData.pincode,
      street: allAddressData.street,
    );
  }

  void onMapTap(LatLng location) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(location.latitude, location.longitude);

    markers.clear();
    markers.add(Marker(
      markerId: MarkerId(location.toString()),
      position: location,
    ));

    placename =
        "${placemark[1].name},${placemark[1].subLocality},\n${placemark[1].locality},${placemark[1].street},\n${placemark[1].country},${placemark[1].postalCode}";

    allAddressData = DelivaryAddressModel(
        fullname: "${placemark[1].name}",
        city: "${placemark[1].subLocality}",
        landMark: "${placemark[1].locality}",
        street: "${placemark[1].street}",
        number: "${placemark[1].country}",
        pincode: "${placemark[1].postalCode}");
    notifyListeners();
  }

  void onmapcreate(googleController) {
    mapController = googleController;
    notifyListeners();
  }
}

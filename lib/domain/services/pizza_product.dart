import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hungryhub/model/all_product_model.dart.dart';

final CollectionReference pizzaCollect =
    FirebaseFirestore.instance.collection('pizza');

Stream<List<AllProductDetails>> getPizzaStream() {
  return pizzaCollect.snapshots().map((event) {
    return event.docs.map((e) {
      return AllProductDetails.fromjson(e.data() as Map<String, dynamic>);
    }).toList();
  });
}

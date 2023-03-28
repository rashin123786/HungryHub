import 'package:cloud_firestore/cloud_firestore.dart';

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

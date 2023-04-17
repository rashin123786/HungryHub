import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hungryhub/model/all_product_model.dart.dart';

final CollectionReference pizzaCollect =
    FirebaseFirestore.instance.collection('pizza');

//////////       Get Pizza List     ///////////////////////

Stream<List<AllProductDetails>> getPizzaStream() {
  return pizzaCollect.snapshots().map((event) {
    return event.docs.map((e) {
      return AllProductDetails.fromjson(e.data() as Map<String, dynamic>);
    }).toList();
  });
}

//////////       search Burger List     ///////////////////////

Stream<List<AllProductDetails>> searchPizza(String searchquey) {
  return pizzaCollect.snapshots().map((event) {
    return event.docs
        .map(
            (e) => AllProductDetails.fromjson(e.data() as Map<String, dynamic>))
        .where((element) {
      return element.productName
          .toLowerCase()
          .contains(searchquey.toLowerCase());
    }).toList();
  });
}

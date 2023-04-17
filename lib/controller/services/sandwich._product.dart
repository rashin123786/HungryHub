import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hungryhub/model/all_product_model.dart.dart';

final CollectionReference sandwichCollect =
    FirebaseFirestore.instance.collection('sandwiches');

//////////       Get sandwich List     ///////////////////////

Stream<List<AllProductDetails>> getSandwichStream() {
  return sandwichCollect.snapshots().map((event) {
    return event.docs.map((e) {
      return AllProductDetails.fromjson(e.data() as Map<String, dynamic>);
    }).toList();
  });
}

Stream<List<AllProductDetails>> searchSandwich(String query) {
  return sandwichCollect.snapshots().map((event) {
    return event.docs
        .map(
            (e) => AllProductDetails.fromjson(e.data() as Map<String, dynamic>))
        .where((element) {
      return element.productName.toLowerCase().contains(query.toLowerCase());
    }).toList();
  });
}

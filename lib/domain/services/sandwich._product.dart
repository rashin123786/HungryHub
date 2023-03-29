import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hungryhub/model/all_product_model.dart.dart';

final CollectionReference sandwichCollect =
    FirebaseFirestore.instance.collection('sandwiches');

Stream<List<AllProductDetails>> getSandwichStream() {
  return sandwichCollect.snapshots().map((event) {
    return event.docs.map((e) {
      return AllProductDetails.fromjson(e.data() as Map<String, dynamic>);
    }).toList();
  });
}

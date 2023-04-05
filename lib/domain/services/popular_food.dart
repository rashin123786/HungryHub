import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hungryhub/model/all_product_model.dart.dart';

final CollectionReference popularFoodCollect =
    FirebaseFirestore.instance.collection('popularfood');

//////////       Get popular List     ///////////////////////

Stream<List<AllProductDetails>> getPopularStream() {
  return popularFoodCollect.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      return AllProductDetails.fromjson(doc.data() as Map<String, dynamic>);
    }).toList();
  });
}

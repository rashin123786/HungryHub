import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hungryhub/model/all_product_model.dart.dart';

final CollectionReference offerCollect =
    FirebaseFirestore.instance.collection('offers');

//////////       Get offer List     ///////////////////////

Stream<List<AllProductDetails>> getOfferStream() {
  return offerCollect.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      return AllProductDetails.fromjson(doc.data() as Map<String, dynamic>);
    }).toList();
  });
}

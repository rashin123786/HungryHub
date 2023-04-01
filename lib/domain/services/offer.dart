import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hungryhub/model/all_product_model.dart.dart';

final CollectionReference offerCollect =
    FirebaseFirestore.instance.collection('offers');

Future<List<AllProductDetails>> getUser() async {
  List<AllProductDetails> offerDetailsList = [];
  try {
    QuerySnapshot querySnapshot = await offerCollect.get();
    // ignore: avoid_function_literals_in_foreach_calls
    querySnapshot.docs.forEach((element) {
      offerDetailsList.add(
        AllProductDetails.fromSnapshot(element),
      );
    });
    return offerDetailsList;
  } catch (e) {
    print(e);
    return [];
  }
}

Stream<List<AllProductDetails>> getOfferStream() {
  return offerCollect.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      return AllProductDetails.fromjson(doc.data() as Map<String, dynamic>);
    }).toList();
  });
}

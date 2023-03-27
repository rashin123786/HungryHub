import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/offer_model.dart';

final CollectionReference offerCollect =
    FirebaseFirestore.instance.collection('offers');

// Future<List<OfferModel>> getUser() async {
//   List<OfferModel> offerDetailsList = [];
//   try {
//     QuerySnapshot querySnapshot = await offerCollect.get();
//     // ignore: avoid_function_literals_in_foreach_calls
//     querySnapshot.docs.forEach((element) {
//       offerDetailsList.add(
//         OfferModel.fromSnapshot(element),
//       );
//     });
//     return offerDetailsList;
//   } catch (e) {
//     //  print(e);
//     return [];
//   }
//}

Stream<List<OfferModel>> getOfferStream() {
  return offerCollect.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      return OfferModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  });
}

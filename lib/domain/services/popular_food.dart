import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hungryhub/model/popular_model.dart';

final CollectionReference popularFoodCollect =
    FirebaseFirestore.instance.collection('popularfood');

Stream<List<PopularFood>> getPopularStream() {
  return popularFoodCollect.snapshots().map(
    (snapshot) {
      return snapshot.docs.map(
        (popular) {
          return PopularFood.fromjson(popular.data() as Map<String, dynamic>);
        },
      ).toList();
    },
  );
}

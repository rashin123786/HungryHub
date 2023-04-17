import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:hungryhub/model/order_history_model.dart';

final CollectionReference historyCollect = FirebaseFirestore.instance
    .collection('orderhistory')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection("yourorder");

Stream<List<OrderHistoryModel>> getOrderHistoryStrem() {
  return historyCollect.snapshots().map((event) {
    return event.docs.map((e) {
      return OrderHistoryModel.fromjson(e.data() as Map<String, dynamic>);
    }).toList();
  });
}

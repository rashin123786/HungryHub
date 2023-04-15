import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hungryhub/model/order_history_model.dart';
import 'package:hungryhub/view/orderhistory/order_history.dart';

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

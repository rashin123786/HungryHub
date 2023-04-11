import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hungryhub/model/order_history_model.dart';
import 'package:hungryhub/view/orderhistory/order_history.dart';

final CollectionReference historyCollect =
    FirebaseFirestore.instance.collection('orderhistory');

Stream<List<OrderHistoryModel>> getOrderHistoryStrem() {
  return historyCollect.snapshots().map((event) {
    return event.docs.map((e) {
      return OrderHistoryModel.fromjson(e.data() as Map<String, dynamic>);
    }).toList();
  });
}

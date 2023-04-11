class OrderHistoryModel {
  String paymentId;
  num amount;
  String dateTime;
  OrderHistoryModel(
      {required this.amount, required this.dateTime, required this.paymentId});

  factory OrderHistoryModel.fromjson(Map<String, dynamic> json) {
    return OrderHistoryModel(
        amount: json['amount'],
        dateTime: json["dateTime"],
        paymentId: json["paymentId"]);
  }
}

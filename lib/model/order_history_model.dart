class OrderHistoryModel {
  String paymentId;
  num amount;
  String dateTime;
  List<String>? productName;
  List<int>? productRate;
  List<int>? producutQuantity;

  OrderHistoryModel({
    required this.amount,
    required this.dateTime,
    required this.paymentId,
    this.productName,
    this.productRate,
    this.producutQuantity,
  });

  factory OrderHistoryModel.fromjson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      amount: json['amount'],
      dateTime: json["dateTime"],
      paymentId: json["paymentId"],
      productName: List<String>.from(json["productName"] ?? []),
      productRate: List<int>.from(json["productRate"] ?? []),
      producutQuantity: List<int>.from(json["productquantity"] ?? []),
    );
  }
}

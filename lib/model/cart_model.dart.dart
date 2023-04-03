class CartModel {
  final String? id;
  final String productImage;
  final String productName;
  final int productRate;
  final String productDescription;
  final String productTime;
  final int? produtQuantity;
  CartModel({
    this.id,
    required this.productImage,
    required this.productName,
    required this.productRate,
    required this.productDescription,
    required this.productTime,
    this.produtQuantity,
  });

  // factory CartModel.fromjson(Map<String, dynamic> json) {
  //   return CartModel(
  //     id: json['productId'],
  //     productImage: json['productImg'],
  //     productName: json['productName'],
  //     productRate: json['productRate'],
  //     productDescription: json['productDescription'],
  //     productTime: json['productTime'],
  //   );
  // }
}

class BurgerModel {
  final String? id;
  final String productImage;
  final String productName;
  final int productRate;
  final String productDescription;
  final String productTime;
  BurgerModel({
    this.id,
    required this.productImage,
    required this.productName,
    required this.productRate,
    required this.productDescription,
    required this.productTime,
  });

  factory BurgerModel.fromjson(Map<String, dynamic> json) {
    return BurgerModel(
      productImage: json['productImg'],
      productName: json['productName'],
      productRate: json['productRate'],
      productDescription: json['productDescription'],
      productTime: json['productTime'],
    );
  }
}

class PopularFood {
  final String? id;
  final String productImage;
  final String productName;
  final String productRate;
  final String productRating;
  final String productTime;
  PopularFood({
    this.id,
    required this.productImage,
    required this.productName,
    required this.productRate,
    required this.productRating,
    required this.productTime,
  });

  factory PopularFood.fromjson(Map<String, dynamic> popularjson) {
    return PopularFood(
      productImage: popularjson['productImg'],
      productName: popularjson['productName'],
      productRate: popularjson['productRate'],
      productRating: popularjson['productRating'],
      productTime: popularjson['productTime'],
    );
  }
}

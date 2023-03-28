class AllProductDetails {
  final String? id;
  final String productImage;
  final String productName;
  final String productRate;
  final String productDescription;
  final String productTime;
  AllProductDetails({
    this.id,
    required this.productImage,
    required this.productName,
    required this.productRate,
    required this.productDescription,
    required this.productTime,
  });

  factory AllProductDetails.fromjson(Map<String, dynamic> json) {
    return AllProductDetails(
      productImage: json['productImg'],
      productName: json['productName'],
      productRate: json['productRate'],
      productDescription: json['productDescription'],
      productTime: json['productTime'],
    );
  }

  // factory OfferModel.fromSnapshot(DocumentSnapshot snapshot) {
  //   return OfferModel(
  //     productImage: snapshot.get('productImg'),
  //     productName: snapshot.get('productName'),
  //     productRate: snapshot.get('productRate'),
  //     productRating: snapshot.get('productRating'),
  //     productTime: snapshot.get('productTime'),
  //   );
  // }
}

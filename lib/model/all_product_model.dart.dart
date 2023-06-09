import 'package:cloud_firestore/cloud_firestore.dart';

class AllProductDetails {
  final String? id;
  final String productImage;
  final String productName;
  final int productRate;
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
      id: json['productId'],
      productImage: json['productImg'],
      productName: json['productName'],
      productRate: json['productRate'],
      productDescription: json['productDescription'],
      productTime: json['productTime'],
    );
  }

  // factory AllProductDetails.fromSnapshot(DocumentSnapshot snapshot) {
  //   return AllProductDetails(
  //     productImage: snapshot.get('productImg'),
  //     productName: snapshot.get('productName'),
  //     productRate: snapshot.get('productRate'),
  //     productTime: snapshot.get('productTime'),
  //     productDescription: snapshot.get('productDescription'),
  //   );
  // }

  List<AllProductDetails> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;

      return AllProductDetails(
        id: dataMap['productId'],
        productImage: dataMap['productImg'],
        productName: dataMap['productName'],
        productRate: dataMap['productRate'],
        productDescription: dataMap['productDescription'],
        productTime: dataMap['productTime'],
      );
    }).toList();
  }
}

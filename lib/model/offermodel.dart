import 'package:cloud_firestore/cloud_firestore.dart';

class OfferModel {
  final String? id;
  final String productImage;
  final String productName;
  final String productRate;
  final String productRating;
  final String productTime;
  OfferModel({
    this.id,
    required this.productImage,
    required this.productName,
    required this.productRate,
    required this.productRating,
    required this.productTime,
  });

  factory OfferModel.fromSnapshot(DocumentSnapshot snapshot) {
    return OfferModel(
      productImage: snapshot.get('productImg'),
      productName: snapshot.get('productName'),
      productRate: snapshot.get('productRate'),
      productRating: snapshot.get('productRating'),
      productTime: snapshot.get('productTime'),
    );
  }

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      productImage: json['productImg'],
      productName: json['productName'],
      productRate: json['productRate'],
      productRating: json['productRating'],
      productTime: json['productTime'],
    );
  }
}

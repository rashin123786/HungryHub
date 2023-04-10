// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:hungryhub/model/cart_model.dart.dart';

class OrderItems extends StatelessWidget {
  OrderItems({super.key, required this.cartModel});
  final CartModel cartModel;
  bool? isTrue;

  final num rate = 0.0;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(cartModel.productName),
      leading: Image.network(
        cartModel.productImage,
      ),
      subtitle: Text("${cartModel.produtQuantity}"),
      trailing:
          Text("₹${(cartModel.productRate) * (cartModel.produtQuantity ?? 1)}"),
    );
  }
}

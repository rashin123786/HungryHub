import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class OrderItems extends StatelessWidget {
  OrderItems({super.key});
  bool? isTrue;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
          'https://thumbs.dreamstime.com/b/pizza-pepperoni-cheese-salami-vegetables-58914487.jpg'),
      title: Text("food name"),
      subtitle: Text('rate of product'),
    );
  }
}

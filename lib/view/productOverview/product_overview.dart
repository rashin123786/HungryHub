import 'package:flutter/material.dart';

import 'package:hungryhub/view/Home/home.dart';

class ProductOverView extends StatelessWidget {
  const ProductOverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [Text(datass!.productName)],
      )),
    );
  }
}

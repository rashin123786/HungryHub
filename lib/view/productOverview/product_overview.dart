import 'package:flutter/material.dart';
import 'package:hungryhub/model/offermodel.dart';

import 'package:hungryhub/view/Home/home.dart';

import '../../domain/services/offer.dart';

class ProductOverView extends StatelessWidget {
  const ProductOverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: FutureBuilder(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              OfferModel ofres = snapshot.data![index];
              return ListTile(
                title: Text(ofres.productName),
                subtitle: Text(ofres.productRate),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    )));
  }
}

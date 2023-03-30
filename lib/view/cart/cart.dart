import 'package:flutter/material.dart';
import 'package:hungryhub/domain/services/offer.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: getOfferStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final datafound = snapshot.data![index];
                  return ListTile(
                    title: Text(datafound.productName),
                    subtitle: Text("${datafound.productRate}"),
                  );
                },
              );
            } else {
              return Text('vgbh n');
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungryhub/controller/provider/payment_controller.dart';

import 'package:provider/provider.dart';

import '../../../../controller/constants/constants.dart';
import '../../../../model/cart_model.dart.dart';

List<CartModel> cartModelList = [];

class SuccesPage extends StatelessWidget {
  const SuccesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          color: Colors.white,
          shadowColor: backgroundcolor,
          elevation: 15,
          child: Column(
            children: [
              Image.asset(
                "assets/images/success1.gif",
                width: 200,
                height: 200,
              ),
              Text(
                "Thank YOU",
                style: GoogleFonts.secularOne(
                  fontSize: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  "Thank you for your payment on Hungry Hub! We appreciate your business and hope you enjoy your meal.Your satisfaction is our top priority, and we are honored to have the opportunity to serve you.",
                  style: GoogleFonts.secularOne(
                    fontSize: 18,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              Consumer<PaymentController>(
                builder: (context, value, child) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: backgroundcolor),
                    onPressed: () async {
                      value.addOrderHistory(paymentId!, cartModelList);
                      value.deletecart();
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      cartModelList.clear();
                    },
                    child: const Text(
                      "OK",
                    ),
                  );
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
